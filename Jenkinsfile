#!groovy
@Library('github.com/cloudogu/ces-build-lib@1.67.0')
import com.cloudogu.ces.cesbuildlib.*

git = new Git(this, "cesmarvin")
git.committerName = 'cesmarvin'
git.committerEmail = 'cesmarvin@cloudogu.com'
gitflow = new GitFlow(this, git)
github = new GitHub(this, git)
changelog = new Changelog(this)

repositoryName = "k8s-velero"
productionReleaseBranch = "main"

node('docker') {
    K3d k3d = new K3d(this, "${WORKSPACE}", "${WORKSPACE}/k3d", env.PATH)

    timestamps {
        catchError {
            timeout(activity: false, time: 60, unit: 'MINUTES') {
                stage('Checkout') {
                    checkout scm
                    make 'clean'
                }

                kubevalImage = "cytopia/kubeval:0.15"

                stage("Lint k8s Resources") {
                    new Docker(this)
                            .image(kubevalImage)
                            .inside("-v ${WORKSPACE}/k8s/helm/:/data -t --entrypoint=")
                                    {
                                        sh "kubeval -d /data/templates --ignore-missing-schemas"
                                    }
                }

                stage('Set up k3d cluster') {
                    k3d.startK3d()
                }
                stage('Install kubectl') {
                    k3d.installKubectl()
                }
                stage ('Install golang') {
                    sh "sudo snap install go --classic"
                }

                stage('Test snapshot-controller') {
                    sh "NAMESPACE=default KUBECONFIG=${WORKSPACE}/k3d/.k3d/.kube/config make helm-snapshot-controller-apply"
                    // Sleep because it takes time for the controller to create the resource. Without it would end up
                    // in error "no matching resource found when run the wait command"
                    sleep(20)
                    k3d.kubectl("wait --for=condition=ready deploy -l app=snapshot-controller --timeout=300s")
                }
            }
        }

        stage('Remove k3d cluster') {
            k3d.deleteK3d()
        }

        stageAutomaticRelease()
    }
}

void stageAutomaticRelease() {
    if (gitflow.isReleaseBranch()) {
        Makefile makefile = new Makefile(this)
        String releaseVersion = makefile.getVersion()
        String changelogVersion = git.getSimpleBranchName()
        String registryNamespace = "k8s"
        String registryUrl = "registry.cloudogu.com"

        stage('Finish Release') {
            gitflow.finishRelease(releaseVersion, productionReleaseBranch)
        }

        stage('Generate release resource') {
            make 'generate-release-resource'
        }

        stage('Push to Registry') {
            GString targetEtcdResourceYaml = "target/make/${registryNamespace}/${repositoryName}_${releaseVersion}.yaml"

            DoguRegistry registry = new DoguRegistry(this)
            registry.pushK8sYaml(targetEtcdResourceYaml, repositoryName, registryNamespace, "${releaseVersion}")
        }

        stage('Push Helm chart to Harbor') {
            new Docker(this)
                    .image("golang:1.20")
                    .mountJenkinsUser()
                    .inside("--volume ${WORKSPACE}:/${repositoryName} -w /${repositoryName}")
                            {
                                make 'helm-package-release'

                                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'harborhelmchartpush', usernameVariable: 'HARBOR_USERNAME', passwordVariable: 'HARBOR_PASSWORD']]) {
                                    sh ".bin/helm registry login ${registryUrl} --username '${HARBOR_USERNAME}' --password '${HARBOR_PASSWORD}'"
                                    sh ".bin/helm push target/make/k8s/helm/${repositoryName}-${releaseVersion}.tgz oci://${registryUrl}/${registryNamespace}"
                                }
                            }
        }

        stage('Add Github-Release') {
            releaseId = github.createReleaseWithChangelog(changelogVersion, changelog, productionReleaseBranch)
        }
    }
}

void make(String makeArgs) {
    sh "make ${makeArgs}"
}

{{- /*
k8s-snapshot-controller-crd.labels generates Helm labels.
*/ -}}
{{- define "k8s-snapshot-controller-crd.labels" -}}
app: ces
app.kubernetes.io/name: k8s-snapshot-controller-crd
k8s.cloudogu.com/part-of: backup
{{- end -}}
{{- /*
k8s-snapshot-controller.labels generates Helm labels.
*/ -}}
{{- define "k8s-snapshot-controller.labels" -}}
app: ces
app.kubernetes.io/name: k8s-snapshot-controller
k8s.cloudogu.com/part-of: backup
{{- end -}}
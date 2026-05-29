{{- define "lago-data-rev-rec.fullname" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "lago-data-rev-rec.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
The Flink Kubernetes Operator auto-creates a ClusterIP Service named
<flinkdeployment-name>-rest exposing the JobManager REST API on port 8081.
*/}}
{{- define "lago-data-rev-rec.flinkRest" -}}
{{- printf "%s-rest" (include "lago-data-rev-rec.fullname" .) -}}
{{- end -}}

{{- define "lago-data-rev-rec.submitterImage" -}}
{{- $repo := required "submitter.image.repository is required" .Values.submitter.image.repository -}}
{{- $tag  := required "submitter.image.tag is required"        .Values.submitter.image.tag -}}
{{- printf "%s:%s" $repo $tag -}}
{{- end -}}

{{- define "lago-data-rev-rec.flinkImage" -}}
{{- $repo := required "image.repository is required" .Values.image.repository -}}
{{- $tag  := required "image.tag is required"        .Values.image.tag -}}
{{- printf "%s:%s" $repo $tag -}}
{{- end -}}

{{/*
Name of the ServiceAccount the FlinkDeployment and submitter Job run under.
If serviceAccount.create is true, defaults to the chart fullname; otherwise the
user-supplied serviceAccount.name is required (the lago-data Pulumi component
sets create=false and provides the name).
*/}}
{{- define "lago-data-rev-rec.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default (include "lago-data-rev-rec.fullname" .) .Values.serviceAccount.name -}}
{{- else -}}
{{- required "serviceAccount.name is required when serviceAccount.create is false" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}

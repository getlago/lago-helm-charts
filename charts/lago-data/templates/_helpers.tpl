{{/*
Expand the name of the chart.
*/}}
{{- define "lago-data.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "lago-data.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create argocd application set name and version as used by the chart label.
*/}}
{{- define "lago-data.api.fullname" -}}
{{- printf "%s-%s" (include "lago-data.fullname" .) .Values.api.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "lago-data.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "lago-data.labels" -}}
helm.sh/chart: {{ include "lago-data.chart" .context }}
{{ include "lago-data.selectorLabels" (dict "context" .context "component" .component "name" .name) }}
app.kubernetes.io/managed-by: {{ .context.Release.Service }}
app.kubernetes.io/part-of: lago-data
app.kubernetes.io/version: {{ .context.Chart.AppVersion | quote }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "lago-data.selectorLabels" -}}
{{- if .name -}}
app.kubernetes.io/name: {{ include "lago-data.name" .context }}-{{ .name }}
{{ end -}}
app.kubernetes.io/instance: {{ .context.Release.Name }}
{{- if .component }}
app.kubernetes.io/component: {{ .component }}
{{- end }}
{{- end }}

{{/*
Create the name of the api service account to use
*/}}
{{- define "lago-data.api.serviceAccountName" -}}
{{- if .Values.api.serviceAccount.create }}
{{- default (include "lago-data.api.fullname" .) .Values.api.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.api.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the config map to use
*/}}
{{- define "lago-data.configMapName" -}}
{{- if .Values.configs.cm.create }}
{{- default (include "lago-data.fullname" .) .Values.configs.cm.name }}
{{- else }}
{{- default "default" .Values.configs.cm.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the secret to use
*/}}
{{- define "lago-data.secretName" -}}
{{- if .Values.configs.secret.create }}
{{- default (include "lago-data.fullname" .) .Values.configs.secret.name }}
{{- else }}
{{- default "default" .Values.configs.secret.name }}
{{- end }}
{{- end }}

{{/*
Generate configmap entries and enforce presence
*/}}
{{- define "lago-data.configs.cm" -}}
{{- $config := omit .Values.configs.cm "create" "annotations" "labels" "name" -}}
{{- range $key, $value := $config }}
{{ $key }}: {{ required (printf "%s value is required" $key) $value | quote }}
{{- end}}
{{- end -}}


{{/*
Generate secret entries and enforce presence
*/}}
{{- define "lago-data.configs.secret" -}}
{{- $config := omit .Values.configs.secret "create" "annotations" "labels" "name" -}}
{{- range $key, $value := $config }}
{{ $key }}: {{ required (printf "%s value is required" $key) $value | quote }}
{{- end}}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "lago-data-api.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "lago-data-api.fullname" -}}
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
Create chart name and version as used by the chart label.
*/}}
{{- define "lago-data-api.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "lago-data-api.labels" -}}
helm.sh/chart: {{ include "lago-data-api.chart" . }}
{{ include "lago-data-api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "lago-data-api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "lago-data-api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "lago-data-api.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "lago-data-api.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the config map to use
*/}}
{{- define "lago-data-api.configMapName" -}}
{{- if .Values.config.cm.create }}
{{- default (include "lago-data-api.fullname" .) .Values.config.cm.name }}
{{- else }}
{{- default "default" .Values.config.cm.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the secret to use
*/}}
{{- define "lago-data-api.secretName" -}}
{{- if .Values.config.secret.create }}
{{- default (include "lago-data-api.fullname" .) .Values.config.secret.name }}
{{- else }}
{{- default "default" .Values.config.secret.name }}
{{- end }}
{{- end }}

{{/*
Generate configmap entries and enforce presence
*/}}
{{- define "lago-data-api.config.cm" -}}
{{- $config := omit .Values.config.cm "create" "annotations" "labels" "name" -}}
{{- range $key, $value := $config }}
{{ $key }}: {{ required (printf "%s value is required" $key) $value | quote }}
{{- end}}
{{- end -}}


{{/*
Generate secret entries and enforce presence
*/}}
{{- define "lago-data-api.config.secret" -}}
{{- $config := omit .Values.config.secret "create" "annotations" "labels" "name" -}}
{{- range $key, $value := $config }}
{{ $key }}: {{ required (printf "%s value is required" $key) $value | quote }}
{{- end}}
{{- end -}}

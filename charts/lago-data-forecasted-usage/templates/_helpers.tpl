{{/*
Expand the name of the chart.
*/}}
{{- define "lago-data-forecasted-usage.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "lago-data-forecasted-usage.fullname" -}}
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
{{- define "lago-data-forecasted-usage.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "lago-data-forecasted-usage.labels" -}}
helm.sh/chart: {{ include "lago-data-forecasted-usage.chart" . }}
{{ include "lago-data-forecasted-usage.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "lago-data-forecasted-usage.selectorLabels" -}}
app.kubernetes.io/name: {{ include "lago-data-forecasted-usage.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "lago-data-forecasted-usage.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "lago-data-forecasted-usage.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Get the name of the S3 secret
*/}}
{{- define "lago-data-forecasted-usage.s3.secretName" -}}
{{- if .Values.config.s3.secret.name }}
{{- .Values.config.s3.secret.name }}
{{- else }}
{{- printf "%s-s3" (include "lago-data-forecasted-usage.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Get the name of the ML secret
*/}}
{{- define "lago-data-forecasted-usage.ml.secretName" -}}
{{- if .Values.config.ml.secret.name }}
{{- .Values.config.ml.secret.name }}
{{- else }}
{{- printf "%s-ml" (include "lago-data-forecasted-usage.fullname" .) }}
{{- end }}
{{- end }}


{{- define "lago-data-forecasted-usage.configMapName" -}}
{{- mustMergeOverwrite .Values .Values.config | set . "Values" | include "lago-data-config.configMapName" }}
{{- end }}

{{- define "lago-data-forecasted-usage.secretName" -}}
{{- mustMergeOverwrite .Values .Values.config | set . "Values" | include "lago-data-config.secretName" }}
{{- end }}

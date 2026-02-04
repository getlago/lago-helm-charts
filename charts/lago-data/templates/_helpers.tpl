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
Create chart name and version as used by the chart label.
*/}}
{{- define "lago-data.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "lago-data.labels" -}}
helm.sh/chart: {{ include "lago-data.chart" . }}
{{ include "lago-data.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "lago-data.selectorLabels" -}}
app.kubernetes.io/name: {{ include "lago-data.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Config map name (from lago-data-config)
*/}}
{{- define "lago-data.configMapName" -}}
{{- mustMergeOverwrite .Values (index .Values "data-config") | set . "Values" | include "lago-data-config.configMapName" }}
{{- end }}

{{/*
Secret name (from lago-data-config)
*/}}
{{- define "lago-data.secretName" -}}
{{- mustMergeOverwrite .Values (index .Values "data-config") | set . "Values" | include "lago-data-config.secretName" }}
{{- end }}

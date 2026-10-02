{{/*
Expand the name of the chart.
*/}}
{{- define "lago-events-processor-worker.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "lago-events-processor-worker.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else if contains .Release.Name $name }}
{{- $name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "lago-events-processor-worker.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "lago-events-processor-worker.labels" -}}
helm.sh/chart: {{ include "lago-events-processor-worker.chart" . }}
{{ include "lago-events-processor-worker.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "lago-events-processor-worker.selectorLabels" -}}
app.kubernetes.io/name: {{ include "lago-events-processor-worker.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "lago-events-processor-worker.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "lago-events-processor-worker.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{- define "lago-events-processor-worker.version" -}}
{{ coalesce .Values.image.tag .Values.global.lago.version .Chart.AppVersion }}
{{- end }}

{{- define "lago-events-processor-worker.configMapName" -}}
{{- mustMergeOverwrite .Values .Values.config | set . "Values" | include "lago-config.configMapName" }}
{{- end }}

{{- define "lago-events-processor-worker.secretName" -}}
{{- mustMergeOverwrite .Values .Values.config | set . "Values" | include "lago-config.secretName" }}
{{- end }}

{{- define "lago-events-processor-worker.streaming.configMapName" -}}
{{- mustMergeOverwrite .Values .Values.config | set . "Values" | include "lago-config.streaming.configMapName" }}
{{- end }}

{{- define "lago-events-processor-worker.streaming.secretName" -}}
{{- mustMergeOverwrite .Values .Values.config | set . "Values" | include "lago-config.streaming.secretName" }}
{{- end }}

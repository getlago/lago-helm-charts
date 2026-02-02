{{/*
Expand the name of the chart.
*/}}
{{- define "lago-config.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "lago-config.fullname" -}}
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
{{- define "lago-config.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "lago-config.labels" -}}
helm.sh/chart: {{ include "lago-config.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the config map to use
*/}}
{{- define "lago-config.configMapName" -}}
{{- if and .Values.configmap .Values.configmap.name }}
{{- .Values.configmap.name }}
{{- else if and .Values.config .Values.config.configmap .Values.config.configmap.name }}
{{- .Values.config.configmap.name }}
{{- else if and .Values.global .Values.global.config .Values.global.config.configmap }}
{{- .Values.global.config.configmap }}
{{- else }}
{{- include "lago-config.fullname" . }}
{{- end }}
{{- end }}

{{- define "lago-config.streaming.configMapName" -}}
{{- if and .Values.configmapStreaming .Values.configmapStreaming.name }}
{{- .Values.configmapStreaming.name }}
{{- else if and .Values.config .Values.config.configmapStreaming .Values.config.configmapStreaming.name }}
{{- .Values.config.configmapStreaming.name }}
{{- else if and .Values.global .Values.global.streaming_ingestion .Values.global.streaming_ingestion.configmap }}
{{- .Values.global.streaming_ingestion.configmap }}
{{- else }}
{{- include "lago-config.fullname" . }}-streaming
{{- end }}
{{- end }}


{{/*
Create the name of the secret to use
*/}}
{{- define "lago-config.secretName" -}}
{{- if and .Values.secret .Values.secret.name }}
{{- .Values.secret.name }}
{{- else if and .Values.config .Values.config.secret .Values.config.secret.name }}
{{- .Values.config.secret.name }}
{{- else if and .Values.global .Values.global.config .Values.global.config.secret }}
{{- .Values.global.config.secret }}
{{- else }}
{{- include "lago-config.fullname" . }}
{{- end }}
{{- end }}

{{- define "lago-config.streaming.secretName" -}}
{{- if and .Values.secretStreaming .Values.secretStreaming.name }}
{{- .Values.secretStreaming.name }}
{{- else if and .Values.config .Values.config.secretStreaming .Values.config.secretStreaming.name }}
{{- .Values.config.secretStreaming.name }}
{{- else if and .Values.global .Values.global.streaming_ingestion .Values.global.streaming_ingestion.secret }}
{{- .Values.global.streaming_ingestion.secret }}
{{- else }}
{{- include "lago-config.fullname" . }}-streaming
{{- end }}
{{- end }}

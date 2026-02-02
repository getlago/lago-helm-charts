{{/*
Expand the name of the chart.
*/}}
{{- define "lago-data-config.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "lago-data-config.fullname" -}}
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
{{- define "lago-data-config.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "lago-data-config.labels" -}}
helm.sh/chart: {{ include "lago-data-config.chart" . }}
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
{{- define "lago-data-config.configMapName" -}}
{{- if and .Values.configmap .Values.configmap.name }}
{{- .Values.configmap.name }}
{{- else if and .Values.data .Values.data.configmap .Values.data.configmap.name }}
{{- .Values.data.configmap.name }}
{{- else if and .Values.global .Values.global.data .Values.global.data.configmap }}
{{- .Values.global.data.configmap }}
{{- else }}
{{- include "lago-data-config.fullname" . }}
{{- end }}
{{- end }}

{{/*
Create the name of the secret to use
*/}}
{{- define "lago-data-config.secretName" -}}
{{- if and .Values.secret .Values.secret.name }}
{{- .Values.secret.name }}
{{- else if and .Values.data .Values.data.secret .Values.data.secret.name }}
{{- .Values.data.secret.name }}
{{- else if and .Values.global .Values.global.data .Values.global.data.secret }}
{{- .Values.global.data.secret }}
{{- else }}
{{- include "lago-data-config.fullname" . }}
{{- end }}
{{- end }}

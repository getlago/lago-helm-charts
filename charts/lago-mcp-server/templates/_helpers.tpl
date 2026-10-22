{{/*
Expand the name of the chart.
*/}}
{{- define "lago-mcp-server.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "lago-mcp-server.fullname" -}}
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
{{- define "lago-mcp-server.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "lago-mcp-server.labels" -}}
helm.sh/chart: {{ include "lago-mcp-server.chart" . }}
{{ include "lago-mcp-server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "lago-mcp-server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "lago-mcp-server.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "lago-mcp-server.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "lago-mcp-server.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Inside the lago chart (`global.mcp.enabled`), read the Mistral credentials
from the lago-config Secret, like the other subcharts.
*/}}
{{- define "lago-mcp-server.lagoConfig" -}}
{{- if and (not .Values.existingSecret) .Values.global .Values.global.mcp .Values.global.mcp.enabled }}true{{ end }}
{{- end }}

{{/*
Get the name of the secret
*/}}
{{- define "lago-mcp-server.secretName" -}}
{{- if .Values.existingSecret }}
{{- .Values.existingSecret }}
{{- else if include "lago-mcp-server.lagoConfig" . }}
{{- mustMergeOverwrite .Values .Values.config | set . "Values" | include "lago-config.secretName" }}
{{- else }}
{{- include "lago-mcp-server.fullname" . }}
{{- end }}
{{- end }}

{{/*
Lago API URL: config.api.url, else global.urls.api.
*/}}
{{- define "lago-mcp-server.apiURL" -}}
{{- if .Values.config.api.url }}
{{- .Values.config.api.url }}
{{- else if and .Values.global .Values.global.urls .Values.global.urls.api }}
{{- printf "%s/api/v1" .Values.global.urls.api }}
{{- end }}
{{- end }}

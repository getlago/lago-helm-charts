{{/*
Expand the name of the chart.
*/}}
{{- define "lago-rails.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "lago-rails.fullname" -}}
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
{{- define "lago-rails.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "lago-rails.labels" -}}
helm.sh/chart: {{ include "lago-rails.chart" . }}
{{ include "lago-rails.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "lago-rails.selectorLabels" -}}
app.kubernetes.io/name: {{ include "lago-rails.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Return true when the current resource is the arm64 architecture variant.
*/}}
{{- define "lago-rails.architecture.isArm64" -}}
{{- eq (default "amd64" .Values.internalArchitecture) "arm64" -}}
{{- end }}

{{/*
Create an architecture-specific workload name without changing the existing
amd64 name.
*/}}
{{- define "lago-rails.architecture.fullname" -}}
{{- $fullname := include "lago-rails.fullname" . -}}
{{- if eq (include "lago-rails.architecture.isArm64" .) "true" -}}
{{- printf "%s-arm64" .Values.internalArchitectureFullname | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $fullname -}}
{{- end -}}
{{- end }}

{{/*
Create architecture-specific selector labels. The amd64 result delegates to
the existing helper so its rendered labels do not change.
*/}}
{{- define "lago-rails.architecture.selectorLabels" -}}
{{- if eq (include "lago-rails.architecture.isArm64" .) "true" -}}
app.kubernetes.io/name: {{ printf "%s-arm64" .Values.internalArchitectureName | trunc 63 | trimSuffix "-" }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- else -}}
{{- include "lago-rails.selectorLabels" . -}}
{{- end -}}
{{- end }}

{{/*
Create architecture-specific labels. The amd64 result delegates to the
existing helper so its rendered labels do not change.
*/}}
{{- define "lago-rails.architecture.labels" -}}
{{- if eq (include "lago-rails.architecture.isArm64" .) "true" -}}
helm.sh/chart: {{ include "lago-rails.chart" . }}
{{ include "lago-rails.architecture.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- else -}}
{{- include "lago-rails.labels" . -}}
{{- end -}}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "lago-rails.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "lago-rails.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{- define "lago-rails.version" -}}
{{ coalesce .Values.image.tag .Values.global.lago.version .Chart.AppVersion }}
{{- end }}

{{- define "lago-rails.configMapName" -}}
{{- mustMergeOverwrite .Values .Values.config | set . "Values" | include "lago-config.configMapName" }}
{{- end }}

{{- define "lago-rails.secretName" -}}
{{- mustMergeOverwrite .Values .Values.config | set . "Values" | include "lago-config.secretName" }}
{{- end }}

{{- define "lago-rails.streaming.configMapName" -}}
{{- mustMergeOverwrite .Values .Values.config | set . "Values" | include "lago-config.streaming.configMapName" }}
{{- end }}

{{- define "lago-rails.streaming.secretName" -}}
{{- mustMergeOverwrite .Values .Values.config | set . "Values" | include "lago-config.streaming.secretName" }}
{{- end }}

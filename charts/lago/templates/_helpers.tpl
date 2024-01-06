{{/*
Expand the name of the chart.
*/}}
{{- define "lago.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "lago.fullname" -}}
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
{{- define "lago.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "lago.labels" -}}
helm.sh/chart: {{ include "lago.chart" . }}
{{ include "lago.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "lago.selectorLabels" -}}
app.kubernetes.io/name: {{ include "lago.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "lago.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "lago.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified component name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
Usage:
{{ include "lago.component.fullname" (dict "componentName" "component-name" "context" $) }}
*/}}
{{- define "lago.component.fullname" -}}
{{- if .context.Values.fullnameOverride }}
{{- printf "%s-%s" .context.Values.fullnameOverride .componentName | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .context.Chart.Name .context.Values.nameOverride }}
{{- if contains $name .context.Release.Name }}
{{- printf "%s-%s" .context.Release.Name .componentName | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s-%s" .context.Release.Name $name .componentName | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Metadata labels for chart component
Usage:
{{ include "lago.component.labels" (dict "componentName" "component-name" "context" $) }}
*/}}
{{- define "lago.component.labels" -}}
helm.sh/chart: {{ include "lago.chart" .context }}
{{ include "lago.component.selectorLabels" (dict "componentName" .componentName "context" .context) }}
{{- if .context.Chart.AppVersion }}
app.kubernetes.io/version: {{ .context.Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .context.Release.Service }}
{{- end }}


{{/*
Selector labels for chart component
Usage:
{{ include "lago.component.selectorLabels" (dict "componentName" "component-name" "context" $) }}
*/}}
{{- define "lago.component.selectorLabels" -}}
{{ include "lago.selectorLabels" .context }}
app.kubernetes.io/component: {{ .componentName }}
{{- end }}


{{/*
lago license secret name
*/}}
{{- define "lago.lagoLicenseSecretName" -}}
{{- if .Values.secrets.lagoCrypt.useExisting -}}
{{ .Values.secrets.lagoLicense.secretName }}
{{- else -}}
{{ template "lago.fullname" . }}-{{ .Values.secrets.lagoLicense.secretName }}
{{- end -}}
{{- end -}}

{{/*
lago crypt secret name
*/}}
{{- define "lago.lagoCryptSecretName" -}}
{{- if .Values.secrets.lagoCrypt.useExisting -}}
{{ .Values.secrets.lagoCrypt.secretName }}
{{- else -}}
{{ template "lago.fullname" . }}-{{ .Values.secrets.lagoCrypt.secretName }}
{{- end -}}
{{- end -}}

{{/*
postgresql secret name
*/}}
{{- define "lago.postgresqlSecretName" -}}
{{- if .Values.secrets.postgresql.useExisting -}}
{{ .Values.secrets.postgresql.secretName }}
{{- else -}}
{{ template "lago.fullname" . }}-{{ .Values.secrets.postgresql.secretName }}
{{- end -}}
{{- end -}}

{{/*
redis secret name
*/}}
{{- define "lago.redisSecretName" -}}
{{- if .Values.secrets.redis.useExisting -}}
{{ .Values.secrets.redis.secretName }}
{{- else -}}
{{ template "lago.fullname" . }}-{{ .Values.secrets.redis.secretName }}
{{- end -}}
{{- end -}}

{{/*
smtp secret name
*/}}
{{- define "lago.smtpSecretName" -}}
{{- if .Values.secrets.smtp.useExisting -}}
{{ .Values.secrets.smtp.secretName }}
{{- else -}}
{{ template "lago.fullname" . }}-{{ .Values.secrets.smtp.secretName }}
{{- end -}}
{{- end -}}

{{/*
newRelic secret name
*/}}
{{- define "lago.newRelicSecretName" -}}
{{- if .Values.secrets.newRelic.useExisting -}}
{{ .Values.secrets.newRelic.secretName }}
{{- else -}}
{{ template "lago.fullname" . }}-{{ .Values.secrets.newRelic.secretName }}
{{- end -}}
{{- end -}}

{{/*
s3 secret name
*/}}
{{- define "lago.s3SecretName" -}}
{{- if .Values.secrets.s3.useExisting -}}
{{ .Values.secrets.s3.secretName }}
{{- else -}}
{{ template "lago.fullname" . }}-{{ .Values.secrets.s3.secretName }}
{{- end -}}
{{- end -}}

{{/*
api internal url
*/}}
{{- define "lago.apiInternalUrl" -}}
http://{{ .Release.Name }}-lago-api:{{ .Values.api.service.port }}
{{- end -}}

{{/*
pdl url url
*/}}
{{- define "lago.pdfInternalUrl" -}}
http://{{ .Release.Name }}-lago-pdf:{{ .Values.pdf.service.port }}
{{- end -}}

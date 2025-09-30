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
API specific selector labels and labels

We keep io.lago.service for backwards compatibility, but it's not used in the deployment.
*/}}
{{- define "lago.api.labels" -}}
{{ include "lago.labels" . }}
app.kubernetes.io/component: api
io.lago.service: {{ .Release.Name }}-api
{{- end }}

{{- define "lago.api.selectorLabels" -}}
{{ include "lago.selectorLabels" . }}
app.kubernetes.io/component: api
{{- end }}

{{/*
Billing Worker specific selector labels and labels

We keep io.lago.service for backwards compatibility, but it's not used in the deployment.
*/}}
{{- define "lago.billing-worker.labels" -}}
{{ include "lago.labels" . }}
app.kubernetes.io/component: billing-worker
io.lago.service: {{ .Release.Name }}-billing-worker
{{- end }}

{{- define "lago.billing-worker.selectorLabels" -}}
{{ include "lago.selectorLabels" . }}
app.kubernetes.io/component: billing-worker
{{- end }}

{{/*
Clock specific selector labels and labels

We keep io.lago.service for backwards compatibility, but it's not used in the deployment.
*/}}
{{- define "lago.clock.labels" -}}
{{ include "lago.labels" . }}
app.kubernetes.io/component: clock
io.lago.service: {{ .Release.Name }}-clock
{{- end }}

{{- define "lago.clock.selectorLabels" -}}
{{ include "lago.selectorLabels" . }}
app.kubernetes.io/component: clock
{{- end }}

{{/*
Clock Worker specific selector labels and labels

We keep io.lago.service for backwards compatibility, but it's not used in the deployment.
*/}}
{{- define "lago.clock-worker.labels" -}}
{{ include "lago.labels" . }}
app.kubernetes.io/component: clock-worker
io.lago.service: {{ .Release.Name }}-clock-worker
{{- end }}

{{- define "lago.clock-worker.selectorLabels" -}}
{{ include "lago.selectorLabels" . }}
app.kubernetes.io/component: clock-worker
{{- end }}

{{/*
Events Worker specific selector labels and labels

We keep io.lago.service for backwards compatibility, but it's not used in the deployment.
*/}}
{{- define "lago.events-worker.labels" -}}
{{ include "lago.labels" . }}
app.kubernetes.io/component: events-worker
io.lago.service: {{ .Release.Name }}-events-worker
{{- end }}

{{- define "lago.events-worker.selectorLabels" -}}
{{ include "lago.selectorLabels" . }}
app.kubernetes.io/component: events-worker
{{- end }}

{{/*
Front specific selector labels and labels

We keep io.lago.service for backwards compatibility, but it's not used in the deployment.
*/}}
{{- define "lago.front.labels" -}}
{{ include "lago.labels" . }}
app.kubernetes.io/component: front
io.lago.service: {{ .Release.Name }}-front
{{- end }}

{{- define "lago.front.selectorLabels" -}}
{{ include "lago.selectorLabels" . }}
app.kubernetes.io/component: front
io.lago.service: {{ .Release.Name }}-front
{{- end }}

{{/*
Migrate job specific  and labels

*/}}
{{- define "lago.migrate.labels" -}}
{{ include "lago.labels" . }}
app.kubernetes.io/component: migrate
io.lago.service: {{ .Release.Name }}-front
{{- end }}

{{/*
Payment Worker specific selector labels and labels

We keep io.lago.service for backwards compatibility, but it's not used in the deployment.
*/}}
{{- define "lago.payment-worker.labels" -}}
{{ include "lago.labels" . }}
app.kubernetes.io/component: payment-worker
io.lago.service: {{ .Release.Name }}-payment-worker
{{- end }}

{{- define "lago.payment-worker.selectorLabels" -}}
{{ include "lago.selectorLabels" . }}
app.kubernetes.io/component: payment-worker
{{- end }}

{{/*
PDF specific selector labels and labels

We keep io.lago.service for backwards compatibility, but it's not used in the deployment.
*/}}
{{- define "lago.pdf.labels" -}}
{{ include "lago.labels" . }}
app.kubernetes.io/component: pdf
io.lago.service: {{ .Release.Name }}-pdf
{{- end }}

{{- define "lago.pdf.selectorLabels" -}}
{{ include "lago.selectorLabels" . }}
app.kubernetes.io/component: pdf
{{- end }}

{{/*
PDF Worker specific selector labels and labels

We keep io.lago.service for backwards compatibility, but it's not used in the deployment.
*/}}
{{- define "lago.pdf-worker.labels" -}}
{{ include "lago.labels" . }}
app.kubernetes.io/component: pdf-worker
io.lago.service: {{ .Release.Name }}-pdf-worker
{{- end }}

{{- define "lago.pdf-worker.selectorLabels" -}}
{{ include "lago.selectorLabels" . }}
app.kubernetes.io/component: pdf-worker
{{- end }}

{{/*
Storage specific labels

We keep io.lago.service for backwards compatibility, but it's not used in the deployment.
*/}}
{{- define "lago.storage.labels" -}}
{{ include "lago.labels" . }}
app.kubernetes.io/component: storage
io.lago.service: {{ .Release.Name }}-storage
{{- end }}


{{/*
Storage specific selector labels and labels

We keep io.lago.service for backwards compatibility, but it's not used in the deployment.
*/}}
{{- define "lago.storage.selectorLabels" -}}
{{ include "lago.selectorLabels" . }}
app.kubernetes.io/component: storage
{{- end }}


{{/*
Webhook Worker specific selector labels and labels

We keep io.lago.service for backwards compatibility, but it's not used in the deployment.
*/}}
{{- define "lago.webhook-worker.labels" -}}
{{ include "lago.labels" . }}
app.kubernetes.io/component: webhook-worker
io.lago.service: {{ .Release.Name }}-webhook-worker
{{- end }}

{{- define "lago.webhook-worker.selectorLabels" -}}
{{ include "lago.selectorLabels" . }}
app.kubernetes.io/component: webhook-worker
{{- end }}


{{/*
Worker specific selector labels and labels

We keep io.lago.service for backwards compatibility, but it's not used in the deployment.
*/}}
{{- define "lago.worker.labels" -}}
{{ include "lago.labels" . }}
app.kubernetes.io/component: worker
io.lago.service: {{ .Release.Name }}-worker
{{- end }}

{{- define "lago.worker.selectorLabels" -}}
{{ include "lago.selectorLabels" . }}
app.kubernetes.io/component: worker
{{- end }}

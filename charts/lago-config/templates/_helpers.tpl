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

{{/*
Registry of the streaming consumers: name -> {group, worker}. `group` is the
Karafka consumer group ("" when the consumer is not Karafka); lago-api fixes
these names in `karafka.rb`, so they are constants, not values. `worker` is
the umbrella alias that runs the consumer. eventsChargedInAdvance is always on
with streaming ingestion; the others are switched by
`global.streaming_ingestion.consumers.<name>.enabled`.
*/}}
{{- define "lago-config.streaming.consumers" -}}
{{- dict
  "eventsChargedInAdvance" (dict "group" "lago_events_charged_in_advance_consumer" "worker" "events-consumer-worker")
  "walletRefresh" (dict "group" "lago_wallet_refresh_triggers_consumer" "worker" "wallet-refresh-consumer-worker")
  "walletAlerts" (dict "group" "lago_wallet_alerts_consumer" "worker" "wallet-alerts-consumer-worker")
  "usageAttribution" (dict "group" "lago_usage_attribution_values_consumer" "worker" "usage-attribution-consumer-worker")
  "productEvents" (dict "group" "" "worker" "product-events-processor-worker")
  | toJson -}}
{{- end -}}

{{/*
"true" when `global.streaming_ingestion.consumers.<name>.enabled` is on, else "".
Takes (dict "name" <consumer> "global" .Values.global).
*/}}
{{- define "lago-config.streaming.consumerEnabled" -}}
{{- $c := dig "streaming_ingestion" "consumers" .name nil .global -}}
{{- if and (kindIs "map" $c) $c.enabled }}true{{ end -}}
{{- end -}}

{{/*
Karafka command that runs only the consumer group of the streaming consumer
`.name`: one consumer per process, so each scales and reports on its own.
Takes (dict "name" <consumer> "context" $).
*/}}
{{- define "lago-config.streaming.karafkaCommand" -}}
{{- $group := dig .name "group" "" (include "lago-config.streaming.consumers" .context | fromJson) -}}
{{- if not $group -}}
{{- fail (printf "karafka.consumer %q is not a Karafka consumer of lago-config.streaming.consumers" .name) -}}
{{- end -}}
{{- toJson (list "bundle" "exec" "karafka" "server" "--include_consumer_groups" $group) -}}
{{- end -}}

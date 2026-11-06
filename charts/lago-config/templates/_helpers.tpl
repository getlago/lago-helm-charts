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
Data of the streaming ConfigMap. Kept here, out of streaming-configmap.yaml,
so that lago-rails can hash it (lago-rails.streaming.configMapChecksum) and
roll its pods when it changes: envFrom alone does not restart them. It only
reads .Values.global, so it renders the same from any chart.
*/}}
{{- define "lago-config.streaming.configMapData" -}}
{{- $kafka := .Values.global.streaming_ingestion.kafka -}}
{{- $clickhouse := .Values.global.streaming_ingestion.clickhouse -}}
{{- if empty $kafka.bootstrapServers }}
{{- fail "If streaming_ingestion is enabled, you must provide a list of Kafka servers" }}
{{- end }}
LAGO_KAFKA_BOOTSTRAP_SERVERS: {{ $kafka.bootstrapServers | join "," }}
LAGO_KAFKA_CONSUMER_GROUP: {{ $kafka.consumerGroup }}
{{- with $kafka.consumerGroupEventsProcessor }}
LAGO_KAFKA_CONSUMER_GROUP_EVENTS_PROCESSOR: {{ . }}
{{- end }}
LAGO_KAFKA_ENRICHED_EVENTS_EXPANDED_TOPIC: {{ $kafka.topics.eventsEnrichedExpanded }}
LAGO_KAFKA_ENRICHED_EVENTS_TOPIC: {{ $kafka.topics.eventsEnriched }}
LAGO_KAFKA_EVENTS_CHARGED_IN_ADVANCE_TOPIC: {{ $kafka.topics.eventsChargedInAdvance }}
LAGO_KAFKA_EVENTS_DEAD_LETTER_TOPIC: {{ $kafka.topics.eventsDeadLetter }}
LAGO_KAFKA_RAW_EVENTS_TOPIC: {{ $kafka.topics.eventsRaw }}
LAGO_KAFKA_PRODUCT_RAW_EVENTS_TOPIC: {{ $kafka.topics.productEventsRaw }}
LAGO_KAFKA_PRODUCT_ENRICHED_EVENTS_TOPIC: {{ $kafka.topics.productEventsEnriched }}
{{- with $kafka.saslMechanisms }}
LAGO_KAFKA_SCRAM_ALGORITHM: {{ $kafka.saslMechanisms }}
LAGO_KAFKA_SASL_MECHANISMS: {{ $kafka.saslMechanisms }}
{{- end }}
{{- if $kafka.securityProtocol }}
LAGO_KAFKA_SECURITY_PROTOCOL: {{ $kafka.securityProtocol }}
{{- end }}
LAGO_KAFKA_TLS: {{ $kafka.tls | quote }}
LAGO_KAFKA_ACTIVITY_LOGS_TOPIC: {{ $kafka.topics.activityLogs }}
LAGO_KAFKA_API_LOGS_TOPIC: {{ $kafka.topics.apiLogs }}
LAGO_KAFKA_SECURITY_LOGS_TOPIC: {{ $kafka.topics.securityLogs }}
{{- /* Producers route wallet alerts to Kafka as soon as the topic is set, so
       only expose it once the consumer that drains it is deployed. */}}
{{- if .Values.global.streaming_ingestion.walletAlertsConsumer }}
LAGO_KAFKA_WALLET_ALERTS_TOPIC: {{ $kafka.topics.walletAlerts }}
{{- end }}
{{- with $kafka.clickhouseConsumerGroup }}
LAGO_KAFKA_CLICKHOUSE_CONSUMER_GROUP: {{ . }}
{{- end }}
LAGO_CLICKHOUSE_PORT: {{ $clickhouse.port | quote }}
LAGO_CLICKHOUSE_HOST: {{ $clickhouse.address }}
{{- with $clickhouse.hostReadOnly }}
LAGO_CLICKHOUSE_HOST_READ_ONLY: {{ . }}
{{- end }}
LAGO_CLICKHOUSE_SSL: {{ $clickhouse.tls | quote }}
LAGO_CLICKHOUSE_ENABLED: "true"
LAGO_CLICKHOUSE_DATABASE: {{$clickhouse.database}}
LAGO_CLICKHOUSE_MIGRATIONS_ENABLED: {{ $clickhouse.migrationsEnabled | quote }}
{{- end }}

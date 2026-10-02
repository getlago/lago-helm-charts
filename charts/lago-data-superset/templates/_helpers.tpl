{{- define "lago-data-superset.fullname" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "lago-data-superset.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{ include "lago-data-superset.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "lago-data-superset.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "lago-data-superset.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default (include "lago-data-superset.fullname" .) .Values.serviceAccount.name -}}
{{- else -}}
{{- required "serviceAccount.name is required when serviceAccount.create is false" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}

{{/* Machinery image (data/superset) — repo+tag required, no baked-in default. */}}
{{- define "lago-data-superset.image" -}}
{{- $repo := required "image.repository is required" .Values.image.repository -}}
{{- $tag  := required "image.tag is required"        .Values.image.tag -}}
{{- printf "%s:%s" $repo $tag -}}
{{- end -}}

{{/* Assets image (data/superset-config) staged into /assets by the init-container. */}}
{{- define "lago-data-superset.assetsImage" -}}
{{- $repo := required "assets.repository is required" .Values.assets.repository -}}
{{- $tag  := required "assets.tag is required"        .Values.assets.tag -}}
{{- printf "%s:%s" $repo $tag -}}
{{- end -}}

{{/*
The stage-assets init-container: runs the busybox assets image and copies its
baked /assets tree into the shared `assets` emptyDir, which the app then mounts
read-only at /assets (the machinery's fixed ASSETS_DIR).
*/}}
{{- define "lago-data-superset.initContainers" -}}
- name: stage-assets
  image: {{ include "lago-data-superset.assetsImage" . | quote }}
  imagePullPolicy: {{ .Values.assets.pullPolicy }}
  command: ["sh", "-c", "cp -a /assets/. /assets-shared/"]
  volumeMounts:
    - name: assets
      mountPath: /assets-shared
{{- end -}}

{{/* envFrom + env blocks shared by web and worker. */}}
{{- define "lago-data-superset.env" -}}
envFrom:
  - secretRef:
      name: {{ required "config.superset.secretKey.secretRef.name is required" .Values.config.superset.secretKey.secretRef.name }}
  {{- with .Values.config.superset.metadataDb.uri.secretRef.name }}
  - secretRef:
      name: {{ . }}
  {{- end }}
  {{- with .Values.config.superset.redis.secretRef.name }}
  - secretRef:
      name: {{ . }}
  {{- end }}
  {{- with .Values.config.superset.admin.secretRef.name }}
  - secretRef:
      name: {{ . }}
  {{- end }}
  {{- with .Values.extraEnvFrom }}
  {{- toYaml . | nindent 2 }}
  {{- end }}
env:
  - name: SUPERSET_ENV
    value: {{ .Values.config.superset.env | quote }}
  - name: SUPERSET_METADATA_DB_POOL_SIZE
    value: {{ .Values.config.superset.metadataDb.poolSize | toString | quote }}
  - name: SUPERSET_METADATA_DB_MAX_OVERFLOW
    value: {{ .Values.config.superset.metadataDb.maxOverflow | toString | quote }}
  - name: SUPERSET_METADATA_DB_POOL_TIMEOUT
    value: {{ .Values.config.superset.metadataDb.poolTimeout | toString | quote }}
  - name: SUPERSET_CELERY_CONCURRENCY
    value: {{ .Values.config.superset.celery.concurrency | toString | quote }}
  - name: SUPERSET_CELERY_LOG_LEVEL
    value: {{ .Values.config.superset.celery.logLevel | quote }}
  - name: SUPERSET_CORS_ORIGINS
    value: {{ required "config.superset.corsOrigins is required" .Values.config.superset.corsOrigins | quote }}
  - name: SUPERSET_GUEST_ROLE
    value: {{ .Values.config.superset.guestRole | quote }}
  - name: SUPERSET_JWT_EXPIRE_MINUTES
    value: {{ .Values.config.superset.jwtExpireMinutes | toString | quote }}
  - name: SUPERSET_CACHE_DEFAULT_TIMEOUT
    value: {{ .Values.config.superset.cacheDefaultTimeout | toString | quote }}
  - name: SUPERSET_LOG_LEVEL
    value: {{ .Values.config.superset.logLevel | quote }}
  - name: SUPERSET_LOCAL_SSL
    value: {{ .Values.config.superset.localSsl | toString | quote }}
  - name: LAGO_BUNDLES
    value: {{ .Values.config.lago.bundles | quote }}
  - name: LAGO_PRUNE
    value: {{ .Values.config.lago.prune | toString | quote }}
  {{- range $name, $val := .Values.extraEnv }}
  {{- if kindIs "map" $val }}
  - name: {{ $name }}
    {{- toYaml $val | nindent 4 }}
  {{- else }}
  - name: {{ $name }}
    value: {{ $val | quote }}
  {{- end }}
  {{- end }}
{{- end -}}

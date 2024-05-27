{{- define "secret-path" }}
{{- if .Values.global.existingSecret -}}
{{ .Values.global.existingSecret }}
{{- else -}}
{{ .Release.Name }}-secrets
{{- end }}
{{- end}}

{{- define "kubectlVersion" }}
{{- if .Values.global.kubectlVersion -}}
{{ .Values.global.kubectlVersion }}
{{- else -}}
{{ printf "%s.%s" .Capabilities.KubeVersion.Major .Capabilities.KubeVersion.Minor }}
{{- end }}
{{- end}}

{{- define "migrateJobName" }}
{{- if .Values.job.mirate.nameOverride -}}
{{ .Values.job.mirate.nameOverride }}
{{- else -}}
{{ printf "%s-migrate-%s" .Release.Name (.Values | toYaml | cat .Chart.Version | sha256sum | trunc 8) }}
{{- end }}
{{- end}}
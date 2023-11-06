{{- define "lago.url" -}}
{{- printf "https://%s" .Values.hostname -}}
{{- end -}}
{{- define "hypertraceDataConfigService.image" -}}
  {{- if and .Values.image.tagOverride  -}}
    {{- printf "%s:%s" .Values.image.repository .Values.image.tagOverride }}
  {{- else -}}
    {{- printf "%s:%s" .Values.image.repository .Chart.AppVersion }}
  {{- end -}}
{{- end -}}
{{- define "creatorservice.image" -}}
  {{- if and .Values.images.creator.tagOverride  -}}
    {{- printf "%s:%s" .Values.images.creator.repository .Values.images.creator.tagOverride }}
  {{- else -}}
    {{- printf "%s:%s" .Values.images.creator.repository .Chart.AppVersion }}
  {{- end -}}
{{- end -}}

{{- define "generatorservice.image" -}}
  {{- if and .Values.images.generator.tagOverride  -}}
    {{- printf "%s:%s" .Values.images.generator.repository .Values.images.generator.tagOverride }}
  {{- else -}}
    {{- printf "%s:%s" .Values.images.generator.repository .Chart.AppVersion }}
  {{- end -}}
{{- end -}}

{{- /* Refer https://github.com/openstack/openstack-helm-infra/blob/master/helm-toolkit/templates/utils/_joinListWithComma.tpl */}}
{{- define "helm-toolkit.utils.joinListWithComma" -}}
{{- $local := dict "first" true -}}
{{- range $k, $v := . -}}{{- if not $local.first -}},{{- end -}}{{- $v -}}{{- $_ := set $local "first" false -}}{{- end -}}
{{- end -}}
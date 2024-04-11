{{/* vim: set filetype=mustache: */}}

{{/*
Return the proper mosquitto image name
*/}}
{{- define "mosquitto.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.mosquitto.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper captureApp image name
*/}}
{{- define "captureApp.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.captureApp.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper intelligentTrain image name
*/}}
{{- define "intelligentTrain.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.intelligentTrain.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper ceqApp image name
*/}}
{{- define "ceqApp.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.ceqApp.image "global" .Values.global) }}
{{- end -}}


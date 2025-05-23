{{/*
Expand the name of the chart.
*/}}
{{- define "remla-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "remla-app.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- printf "%s%s" .Values.global.namePrefix .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s%s-%s" .Values.global.namePrefix .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "remla-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "remla-app.labels" -}}
helm.sh/chart: {{ include "remla-app.chart" . }}
{{ include "remla-app.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.labels.version | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "remla-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "remla-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Frontend name
*/}}
{{- define "remla-app.frontendName" -}}
{{- printf "%s-frontend" (include "remla-app.fullname" .) }}
{{- end }}

{{/*
App Service name
*/}}
{{- define "remla-app.appServiceName" -}}
{{- printf "%s-app-service" (include "remla-app.fullname" .) }}
{{- end }}

{{/*
Model Service name
*/}}
{{- define "remla-app.modelServiceName" -}}
{{- printf "%s-model-service" (include "remla-app.fullname" .) }}
{{- end }}


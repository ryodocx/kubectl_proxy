#!/bin/bash -ex

RS_NAME=($(kubectl get rs -n ${NAMESPACE} -o template --template="{{range .items}}{{if .status.readyReplicas}}{{\$owner_ref := (index .metadata.ownerReferences 0)}}{{if (and (eq \$owner_ref.name \"${DEPLOY_NAME}\") (eq \$owner_ref.kind \"${DEPLOY_KIND:-Deployment}\"))}}{{.metadata.name}} {{end}}{{end}}{{end}}"))
POD_NAME=($(kubectl get pod -n ${NAMESPACE} -o template --template="{{range .items}}{{if (and (eq .status.phase \"Running\") (.metadata.ownerReferences))}}{{\$owner_ref := (index .metadata.ownerReferences 0)}}{{if (and (eq \$owner_ref.name \"$(echo ${RS_NAME} | tr -d ' ')\") (eq \$owner_ref.kind \"ReplicaSet\"))}}{{.metadata.name}} {{end}}{{end}}{{end}}"))

kubectl port-forward -n ${NAMESPACE} $(echo ${POD_NAME} | tr -d ' ') ${LISTEN_PORT:-8080}:${TARGET_PORT}

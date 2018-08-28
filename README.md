# kubectl_proxy

```yaml
# Pod Spec
    spec:
      containers:
      - name: kubectl_proxy
        image: ryodocx/kubectl_proxy
        ports:
        - containerPort: 8080
        env:
        - name: NAMESPACE
          value: namespace
        - name: DEPLOY_NAME
          value: deployment_name
        - name: TARGET_PORT
          value: "3000"
        livenessProbe:
          exec:
            command:
            - curl
            - -f
            - localhost:8080

        volumeMounts:
          - name: kubeconfig
            mountPath: /root/.kube
```

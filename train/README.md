# Train Helm Chart

## Pre-requisites

```yaml
apiVersion: v1
kind: Namespace
metadata:
  labels:
    kubernetes.io/metadata.name: nvidia-device-plugin
    pod-security.kubernetes.io/enforce: privileged
    pod-security.kubernetes.io/enforce-version: v1.24
    pod-security.kubernetes.io/audit: privileged
    pod-security.kubernetes.io/audit-version: v1.24
    pod-security.kubernetes.io/warn: privileged
    pod-security.kubernetes.io/warn-version: v1.24
    security.openshift.io/scc.podSecurityLabelSync: 'true'
  name: nvidia-device-plugin
spec:
  finalizers:
  - kubernetes
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: default-scc
  namespace: nvidia-device-plugin
rules:
- apiGroups:
  - security.openshift.io
  resourceNames:
  - privileged
  resources:
  - securitycontextconstraints
  verbs:
  - use
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: default-scc
  namespace: nvidia-device-plugin
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: default-scc
subjects:
- kind: ServiceAccount
  name: default
  namespace: nvidia-device-plugin
```

```sh
helm repo add nvdp https://nvidia.github.io/k8s-device-plugin
helm upgrade -i nvdp nvdp/nvidia-device-plugin --namespace nvidia-device-plugin --version 0.14.5
```

## Usage

```sh
helm dependency build
helm template foo .  --set kafkaBroker.username=train --set kafkaBroker.password='R3dH4t1!' --set kafkaBroker.bootstrapNode.hostname="FOO.eu-west-3.elb.amazonaws.com" | ssh admin@$JETSON_IP_ADDRESS sudo KUBECONFIG=/var/lib/microshift/resources/kubeadmin/kubeconfig oc apply -f -
```

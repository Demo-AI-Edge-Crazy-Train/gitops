# CI pipelines

## Tekton configuration

```sh
oc patch configmap/feature-flags -n openshift-pipelines --type=merge -p '{"data":{"disable-affinity-assistant":"true"}}'
```

## Setup on AWS

- [Install the AWS EFS CSI Driver Operator](https://docs.openshift.com/container-platform/4.15/storage/container_storage_interface/persistent-storage-csi-aws-efs.html#persistent-storage-csi-olm-operator-install_persistent-storage-csi-aws-efs)

- Install the AWS EFS CSI Driver

```yaml
apiVersion: operator.openshift.io/v1
kind: ClusterCSIDriver
metadata:
    name: efs.csi.aws.com
spec:
  managementState: Managed
```

- [Create an EFS volume](https://docs.aws.amazon.com/efs/latest/ug/gs-step-two-create-efs-resources.html)

- Create the StorageClass

```yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: efs-csi
provisioner: efs.csi.aws.com
parameters:
  provisioningMode: efs-ap
  fileSystemId: fs-123456
  directoryPerms: "700"
  basePath: "/pv"
  uid: "0"
  gid: "0"
```

- [Create and configure access to EFS volumes in AWS](https://docs.openshift.com/container-platform/4.15/storage/container_storage_interface/persistent-storage-csi-aws-efs.html#efs-create-volume_persistent-storage-csi-aws-efs)

## Authentication to the registry

```sh
oc create secret docker-registry quay-authentication --docker-email=nmasse@redhat.com --docker-username=nmasse --docker-password=REDACTED --docker-server=quay.io
oc annotate secret/quay-authentication tekton.dev/docker-0=https://quay.io
```

## GitHub Authentication

```sh
oc apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: github-webhook-secret
type: Opaque
stringData:
  secretToken: $(openssl rand -base64 24)
EOF
```

## Add webhook to git repositories

- Print the relevant information to create the webhook.

```sh
oc get route -n ci-pipelines el-crazy-train -o go-template='https://{{.spec.host}}/{{"\n"}}'
oc get secret -n ci-pipelines github-webhook-secret -o go-template --template='{{.data.secretToken|base64decode}}{{"\n"}}'
```

- Add a webhook on the Crazy Train GitHub repositories.

  - Payload URL: *url above*
  - Content-Type: Application/json
  - Secret: *secret printed above*

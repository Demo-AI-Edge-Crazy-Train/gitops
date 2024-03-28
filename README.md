# Crazy Train demo

## Prepare the cluster

Install the **OpenShift GitOps** operator and fix its configuration.

```sh
oc patch argocd openshift-gitops -n openshift-gitops -p '{"spec":{"server":{"insecure":true,"route":{"enabled": true,"tls":{"termination":"edge","insecureEdgeTerminationPolicy":"Redirect"}}}}}' --type=merge
oc patch argocd openshift-gitops -n openshift-gitops -p '{"spec":{"applicationInstanceLabelKey":"argocd.argoproj.io/instance"}}' --type=merge
```

Get the Webhook URL of your OpenShift Gitops installation

```shell
oc get route -n openshift-gitops openshift-gitops-server -o jsonpath='https://{.spec.host}/api/webhook'
```

Add a webhook to this GitHub/GitLab repo

- Payload URL: _url above_
- Content-Type: Application/json
- SSL verification: disable

Give cluster-admin access rights to the **OpenShift Gitops** operator.

```shell
oc adm policy add-cluster-role-to-user cluster-admin system:serviceaccount:openshift-gitops:openshift-gitops-argocd-application-controller
```


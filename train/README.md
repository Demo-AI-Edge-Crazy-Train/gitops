# Train Helm Chart

## Usage

```sh
helm dependency build
helm template foo .  --set kafkaBroker.username=train --set kafkaBroker.password='R3dH4t1!' --set kafkaBroker.bootstrapNode.hostname="FOO.eu-west-3.elb.amazonaws.com" | ssh admin@$JETSON_IP_ADDRESS sudo KUBECONFIG=/var/lib/microshift/resources/kubeadmin/kubeconfig oc apply -f -
```

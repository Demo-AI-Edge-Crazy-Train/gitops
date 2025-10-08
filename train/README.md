# Train Helm Chart

## Deployment

```sh
helm dependency build
helm template foo .  --set kafkaBroker.username=train --set kafkaBroker.password='R3dH4t1!' --set kafkaBroker.bootstrapNode.hostname="FOO.eu-west-3.elb.amazonaws.com" | ssh admin@$JETSON_IP_ADDRESS sudo KUBECONFIG=/var/lib/microshift/resources/kubeadmin/kubeconfig oc apply -f -
```

## Start the demo

Start the capture.

```sh
oc -n train rsh deploy/capture-app curl -X POST -v http://localhost:8080/capture/start
```

Start the train controller.

```sh
oc -n train scale deploy/train-controller --replicas=1
```

## Stop the demo

Stop the capture.

```sh
oc -n train rsh deploy/capture-app curl -X POST -v http://localhost:8080/capture/stop
```

Stop the train controller.

```sh
oc -n train scale deploy/train-controller --replicas=0
```

# Podman-compose (for development purposes)

## Pre-requisites

```sh
mkdir -p /tmp/broker/mosquitto/{log,config,data} /tmp/crazy-images

cat > /tmp/broker/mosquitto/config/mosquitto.conf <<EOF
user mosquitto
persistence true
persistence_location /mosquitto/data/
listener 1883 0.0.0.0
protocol mqtt
allow_anonymous true
log_dest file /mosquitto/log/mosquitto.log
EOF

chmod -R 777 /tmp/broker /tmp/crazy-images
```

## Install/uninstall the demo

```sh
sudo podman-compose up -d
sudo podman-compose down
```

## Start/stop the demo

```sh
curl -v -X 'GET'  'http://localhost:8082/capture/start' -H 'accept: */*'
curl -v -X 'GET'  'http://localhost:8082/capture/stop' -H 'accept: */*'
```

## Debug

```sh
podman exec -it mosquitto mosquitto_sub -t train-image
```

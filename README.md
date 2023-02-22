# Lago chart

## Status

This chart does __NOT__ handle the bootstrap of the app (rake db:migrate, user creation, etc)

## Configuration

Values in `values.yaml` allow configuration of most of the parts. Default scale is 1 for all deployments, this can be easily changed

A redis deployment and service are now optional. Set `redis.enabled` to `true` to create the deployment and related service for fast and easy prototyping

It supposes you are using externaldns + certmanager for the ingress part (with a cluster issuer named `letsencrypt-prod`)

## ToDo

* Add switches/toggle for anti-affinity stuff ?

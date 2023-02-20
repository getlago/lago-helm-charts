# Lago chart

## Status

This chart has not been used in production yet but works in dev for a few month now
It does __NOT__ handle the bootstrap of the app (rake db:migrate, user creation, etc)

## Configuration

Values in `values.yaml` allow configuration of most of the parts. Default scale is 1 for all deployments, this can be easily changed

It supposes you are using externaldns + certmanager for the ingress part (with a cluster issuer named `letsencrypt-prod`)

## ToDo

* Update to set the hostname only once in `values.yaml`
* Proper boolean to create ingress (or not to)
* Proper boolean to create the redis server (or not to)
* Add switches/toggle for anti-affinity stuff ?

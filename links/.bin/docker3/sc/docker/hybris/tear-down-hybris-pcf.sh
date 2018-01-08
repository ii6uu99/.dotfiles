#!/bin/bash
cf stop hybris-server
cf unbind-service hybris-server disk
cf delete hybris-server -f

cf delete-route local.pcfdev.io --hostname hybris -f
cf delete-route local.pcfdev.io --hostname hybris-ssl -f
cf delete-route local.pcfdev.io --hostname hybris-solr -f
cf delete-route local.pcfdev.io --hostname hybris-debug -f

cf delete-service disk -f
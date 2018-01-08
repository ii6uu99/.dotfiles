#!/bin/bash
export APP_NAME=hybris-server
echo APP_NAME is $APP_NAME

# Create the required services...
cf create-service local-volume free-local-disk disk

# Push the APP but don't start it...
cf push $APP_NAME -o host.pcfdev.io:5000/hybris -f hybris-manifest.yml --no-start

# Attach the disk mounted to /home/hybris...
cf bind-service $APP_NAME disk -c '{"mount":"/home/hybris"}'

export APP_GUID=$(cf app $APP_NAME --guid)
echo APP_GUID is $APP_GUID

# Now make some mods
cf curl /v2/apps/$APP_GUID -X PUT -d '{"ports": [9001,9002,8983,8000]}'

# Do the main 9001 "hybris-console" route mapping...
export ROUTE_NAME=hybris
export PORT=9001
./map-port.sh

# Do the main 9002 "ssl-hybris-console" route mapping...
export ROUTE_NAME=hybris-ssl
export PORT=9002
./map-port.sh

# Do the main 8983 "ssl-hybris-console" route mapping...
export ROUTE_NAME=hybris-solr
export PORT=8983
./map-port.sh

# Do the main 8983 "ssl-hybris-console" route mapping...
export ROUTE_NAME=hybris-debug
export PORT=8000
./map-port.sh

# Now start the app...
cf start $APP_NAME
cf logs $APP_NAME

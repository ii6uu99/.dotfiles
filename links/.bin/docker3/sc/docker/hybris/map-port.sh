#!/bin/bash

if [ -z $APP_NAME ]; then
  echo "The APP NAME has not been set."
  exit 1
fi

if [ -z $ROUTE_NAME ]; then
  echo "The ROUTE NAME has not been set."
  exit 1
fi

if [ -z $PORT ]; then
  echo "The PORT has not been set."
  exit 1
fi

# Create the required ROUTE...
cf create-route pcfdev-space local.pcfdev.io --hostname $ROUTE_NAME

APP_GUID=$(cf app $APP_NAME --guid)
echo APP_GUID=$APP_GUID

echo This bit of the script requires jq...
ROUTE_GUID=$(cf curl /v2/routes?q=host:$ROUTE_NAME | jq --raw-output '.resources[0].metadata.guid')
echo ROUTE_GUID=$ROUTE_GUID

generate_post_data()
{
    cat <<EOF
    {
        "app_guid": "$APP_GUID",
        "route_guid": "$ROUTE_GUID",
        "app_port": $PORT
    }
EOF
}

# Create the required route mapping
echo Mapping route $ROUTE_NAME to port $PORT using $(generate_post_data)
cf curl /v2/route_mappings -X POST -d "$(generate_post_data)"
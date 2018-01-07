#!/bin/bash
#
# Usage:
#   ./run.sh <image>
#
# Example:
#   ./run.sh java:8
#

SCRIPTS_DIR="$PWD/scripts"
RUN_SCRIPT="/tmp/scripts/run_all_scripts"

if [ "$#" -ge 1 ]
then
    images=("$@")
else
    images=($(docker images -q))
fi
echo Checking ${#images[@]} images...
echo

for image in "${images[@]}"
do
    echo -n "$image... "
    docker run --rm -v $SCRIPTS_DIR:/tmp/scripts --entrypoint $RUN_SCRIPT $image
done

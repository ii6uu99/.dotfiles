fly -t local login -c http://localhost:8000
fly -t local set-pipeline -p pcf-sb-demo -c ci/pipeline.yml -l ci/private.yml
fly -t local unpause-pipeline -p pcf-sb-demo
fly -t local trigger-job -j pcf-sb-demo/test

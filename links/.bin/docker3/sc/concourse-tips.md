fly -t gcp-tmp-concourse --help
fly -t gcp-tmp-concourse login --insecure
fly -t gcp-tmp-concourse pipelines
fly -t gcp-tmp-concourse get-pipeline -p attendee-service
fly -t gcp-tmp-concourse set-pipeline -p attendee-service -c ci/pipeline.yml -l ci/private.yml
fly -t gcp-tmp-concourse trigger-job -j attendee-service/test
fly -t gcp-tmp-concourse watch -j attendee-service/test
fly -t gcp-tmp-concourse builds -j attendee-service/deploy
fly -t gcp-tmp-concourse intercept -j attendee-service/deploy -b 7
fly -t gcp-tmp-concourse execute -c ci/tasks/test.yml  -i attendee-service-source=.


fly -t local login -c http://localhost:8000
fly -t local set-pipeline -p pcf-sb-demo -c ci/pipeline.yml -l ci/private.yml
fly -t local unpause-pipeline -p pcf-sb-demo
fly -t local trigger-job -j pcf-sb-demo/test
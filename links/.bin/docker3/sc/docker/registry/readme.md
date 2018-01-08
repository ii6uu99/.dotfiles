# Running a Local Registry for Cloudfoundry

I'm assuming docker for Mac. 
Docker for Mac version 17.03.1
PCF Dev version 0.26.0 (CLI: 1eef0f1, OVA: 0.461.0)

## Starting the registry

````bash
./start-registry.sh
````

In Docker for Mac you now need to expose the resgistry. This is an 'Experimental' feature in 
Preferences -> Daemon -> Basic -> Insecure Registries. Add 'host.pcfdev.io:5000'. 
Apply & Restart

## Adding images to the registry

I'm ging to use this application: https://github.com/cloudfoundry-samples/test-app
It's stored in the Docker Hub here: https://hub.docker.com/r/cloudfoundry/test-app/

````bash
docker pull cloudfoundry/test-app
docker tag cloudfoundry/test-app localhost:5000/cloudfoundry-docker-test-app
docker push localhost:5000/cloudfoundry-docker-test-app
````

## Running the image on PCF Dev

Start PCFDev with the insecure registry feature:

````bash
cf dev start -r host.pcfdev.io:5000
````

Now Push your app using the local insecure registry image.

````bash
cf push cloudfoundry-docker-test-app -o host.pcfdev.io:5000/cloudfoundry-docker-test-app
````

If all goes well, navigate your browser to: http://cloudfoundry-docker-test-app.local.pcfdev.io/
and you should see the Test App screen showing uptime and app index. The app exposes the following 
endpoints: "/", "/env", "/exit", "/index", "/port".

If all does not go well, try the push again. For some reason my first pushes sometimes fail.




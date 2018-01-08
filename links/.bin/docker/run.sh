TEMP_DOCKER_FILE=./_conecta_image.docker

docker stop conecta-docker-runner
docker rm conecta-docker-runner

printf "FROM ruby:2.3.1\n\
RUN mkdir -p /usr/app\n\
WORKDIR /usr/app\n\
RUN apt-get -qq update\n\
RUN apt-get -qq -y install libpq-dev postgresql-server-dev-9.4\n\
COPY Gemfile /usr/app\n\
COPY Gemfile.lock /usr/app\n\
RUN bundle install" > $TEMP_DOCKER_FILE

docker build -f $TEMP_DOCKER_FILE -t dockerized-conecta:latest . || rm -f $TEMP_DOCKER_FILE

rm -f $TEMP_DOCKER_FILE

docker run \
	-d \
	--volume $(pwd)/app:/usr/app/app \
	--volume $(pwd)/config:/usr/app/config \
	--volume $(pwd)/public:/usr/app/public \
	--volume $(pwd)/config.ru:/usr/app/config.ru \
	--volume $(pwd)/config.rb:/usr/app/config.rb \
	--name 'conecta-docker-runner' \
	--publish 9000:9000 \
	dockerized-conecta:latest \
		shotgun --host 0.0.0.0 --port 9000 config.ru

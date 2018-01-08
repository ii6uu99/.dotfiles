FROM openjdk:8-jdk
MAINTAINER Ben Wilcock

RUN mkdir /app
WORKDIR /app
ENTRYPOINT ["./gradlew"]
CMD ["-version", "-clean", "-war"]

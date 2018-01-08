#!/bin/bash
docker pull sanwar/hybris-5-7:latest
docker tag sanwar/hybris-5-7 localhost:5000/hybris
docker push localhost:5000/hybris

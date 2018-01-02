# https://github.com/Leafney/alpine-selenium-chrome

FROM ii6uu99/alpine-miniconda3

RUN apk update && \
	apk add curl unzip libexif udev chromium chromium-chromedriver xvfb && \
	pip install selenium && \
	pip install pyvirtualdisplay

#https://github.com/hmmbug/alpine-scrapy

docker build -t hmmbug/alpine-scrapy .


包括的库：

- libxslt
- libxml2
- jpeg
- tiff
- libpng
- zlib
- git
- curl
- libpq

包含的python库：

- scrapy
- scrapyd
- scrapyd-client
- scrapy-splash
- mysql-connector-python
- simplejson
- elasticsearch
- elasticsearch_dsl
- sqlalchemy
- pillow
- psycopg2

# Volumes

- /var/log/scrapy
- /var/lib/scrapy

# Ports

- 6800

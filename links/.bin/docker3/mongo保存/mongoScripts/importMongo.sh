mongoimport --db test --collection restaurants --drop --file /home/ubuntu/primer-dataset.json
mongoexport --db test --collection restaurants --out /home/ubuntu/primer-dataset.json
mongodump -db test --collection restaurants
mongorestore --db test ~/dump/test
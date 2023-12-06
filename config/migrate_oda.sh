#!/bin/zsh
# Drop the oda database in postgres
PGPASSWORD=root psql -h localhost -U postgres -c "DROP DATABASE IF EXISTS oda;"
PGPASSWORD=root psql -h localhost -U postgres -c "DROP DATABASE IF EXISTS oda_fresh;"

# Create the oda database in postgres
PGPASSWORD=root psql -h localhost -U postgres -c "CREATE DATABASE oda;"
PGPASSWORD=root psql -h localhost -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE oda TO postgres;"


# Run pgloader from docker to load the database
docker run --network host --rm --name pgloader -v ./loadfile.load:/data/loadfile.load dimitri/pgloader:latest pgloader --debug /data/loadfile.load

# Run the python script to rename the columns
python3 rename_postgres.py

# Create fresh clone for cache
PGPASSWORD=root psql -h localhost -U postgres -c "CREATE DATABASE oda_fresh;"
PGPASSWORD=root psql -h localhost -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE oda_fresh TO postgres;"

echo "Dumping oda database to oda.sql"

PGPASSWORD=root pg_dump -h localhost -U postgres oda > oda.sql
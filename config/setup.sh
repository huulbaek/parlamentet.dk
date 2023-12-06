#!/bin/zsh

case $1 in
  oda_create)
    python3 download_oda_bak.py
    # Create a MSSQL docker database
    docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=YourStrong!Passw0rd' \
    -p 1433:1433 --name sql_server -d mcr.microsoft.com/mssql/server:2019-latest

    # Wait for the SQL Server to come up
    echo "Waiting for SQL Server to come up"
    sleep 30

    # Import the .bak file
    docker exec -it sql_server /opt/mssql-tools/bin/sqlcmd \
    -S localhost -U SA -P 'YourStrong!Passw0rd' \
    -Q 'RESTORE DATABASE OdaDB FROM DISK = "/var/opt/mssql/backup/oda.bak" WITH MOVE "OdaDB" TO "/var/opt/mssql/data/OdaDB.mdf", MOVE "OdaDB_log" TO "/var/opt/mssql/data/OdaDB_log.ldf"'
  oda_migrate)
    # Drop the oda database in postgres
    PGPASSWORD=root psql -h localhost -U postgres -c "DROP DATABASE IF EXISTS oda;"
    PGPASSWORD=root psql -h localhost -U postgres -c "DROP DATABASE IF EXISTS oda_fresh;"

    # Create the oda database in postgres
    PGPASSWORD=root psql -h localhost -U postgres -c "CREATE DATABASE oda;"
    PGPASSWORD=root psql -h localhost -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE oda TO postgres;"
    

    # Run the docker command to load the database
    docker run --network host --rm --name pgloader -v ./loadfile.load:/data/loadfile.load dimitri/pgloader:latest pgloader --debug /data/loadfile.load

    # Run the python script to rename the columns
    python3 rename_postgres.py

    # Create fresh clone for cache
    PGPASSWORD=root psql -h localhost -U postgres -c "CREATE DATABASE oda_fresh;"
    PGPASSWORD=root psql -h localhost -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE oda_fresh TO postgres;"
    
    echo "Dumping oda database to oda.sql"

    PGPASSWORD=root pg_dump -h localhost -U postgres oda > oda.sql
    ;;
  prisma)
    rm -rf prisma

    bunx prisma init

    # Drop the oda database in postgres
    PGPASSWORD=root psql -h localhost -U postgres -c "DROP DATABASE IF EXISTS oda;"

    # Create the oda database in postgres
    PGPASSWORD=root psql -h localhost -U postgres -c "CREATE DATABASE oda;"
    PGPASSWORD=root psql -h localhost -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE oda TO postgres;"
    
    # Import from oda_fresh
    PGPASSWORD=root psql -h localhost -U postgres oda < oda.sql

    # Pull the database with prisma
    bunx prisma db pull

    # Generate the artifacts
    bunx prisma generate

    # Create an empty directory for the initial migration
    mkdir -p prisma/migrations/0_init

    # Generate the initial migration
    bunx prisma migrate diff \
    --from-empty \
    --to-schema-datamodel prisma/schema.prisma \
    --script > prisma/migrations/0_init/migration.sql

    bunx prisma migrate resolve --applied 0_init 

    python3 schema_relations.py

    bunx prisma migrate dev --create-only --name "added_relations"

    # # Append relations.sql to the migration.sql
    # cat prisma/migrations/0_init/relations.sql >> prisma/migrations/0_init/migration.sql
    ;;
  *)
    echo "Invalid argument. Please use './setup oda' to setup the oda database or './setup prisma' to setup the prisma database."
    ;;
esac

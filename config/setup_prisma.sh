#!/bin/zsh

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

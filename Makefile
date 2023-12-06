.PHONY: oda_create oda_migrate prisma

oda_create:
	@echo "Downloading .bak file..."
	@python3 download_oda_bak.py
	@echo "Creating MSSQL docker database..."
	@docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=password' -p 1433:1433 --name sql_server -d mcr.microsoft.com/mssql/server:2019-latest
	@echo "Waiting for SQL Server to come up..."
	@sleep 15
	@echo "Importing .bak file..."
	@docker exec -it sql_server /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'password' -Q 'RESTORE DATABASE OdaDB FROM DISK = "/var/opt/mssql/backup/oda.bak" WITH MOVE "OdaDB" TO "/var/opt/mssql/data/OdaDB.mdf", MOVE "OdaDB_log" TO "/var/opt/mssql/data/OdaDB_log.ldf"'

oda_migrate:
	@echo "Migrating Oda database..."
	@./migrate_oda.sh

prisma:
	@echo "Setting up Prisma..."
	@./setup_prisma.sh

help:
	@echo "Available commands:"
	@echo "  make oda_create  - Set up the Oda database"
	@echo "  make oda_migrate - Migrate the Oda database"
	@echo "  make prisma      - Set up Prisma"
	@echo "  make help        - Show this help message"
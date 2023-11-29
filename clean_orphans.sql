-- Delete orphaned rows
DELETE FROM "dagsordenspunktsag"
WHERE "dagsordenspunktid" NOT IN (SELECT "id" FROM "dagsordenspunkt");

-- Delete orphaned rows
DELETE FROM "dagsordenspunktsag"
WHERE "sagid" NOT IN (SELECT "id" FROM "sag");

-- Delete orphaned rows
DELETE FROM "emneordsag"
WHERE "sagid" NOT IN (SELECT "id" FROM "sag");

-- Delete orphaned rows
DELETE FROM "SagAktoer"
WHERE "sagid" NOT IN (SELECT "id" FROM "sag");

-- Delete orphaned rows
DELETE FROM "sagdokument"
WHERE "sagid" NOT IN (SELECT "id" FROM "sag");

-- Delete orphaned rows
DELETE FROM "sagstrin"
WHERE "sagid" NOT IN (SELECT "id" FROM "sag");

-- Delete orphaned rows
DELETE FROM "stemme"
WHERE "aktoerid" NOT IN (SELECT "id" FROM "Aktoer");

DELETE FROM "SagstrinAktoer"
WHERE "sagstrinid" NOT IN (SELECT "id" FROM "sagstrin");

DELETE FROM "afstemning"
WHERE "sagstrinid" NOT IN (SELECT "id" FROM "sagstrin");

-- Delete orphaned rows
DELETE FROM "dagsordenspunkt"
WHERE "sagstrinid" NOT IN (SELECT "id" FROM "sagstrin");

-- Delete orphaned rows
DELETE FROM "dagsordenspunktdokument"
WHERE "dagsordenspunktid" NOT IN (SELECT "id" FROM "dagsordenspunkt");

-- Delete orphaned rows
DELETE FROM "dagsordenspunktsag"
WHERE "dagsordenspunktid" NOT IN (SELECT "id" FROM "dagsordenspunkt");

-- Delete orphaned rows
DELETE FROM "sagstrindokument"
WHERE "sagstrinid" NOT IN (SELECT "id" FROM "sagstrin");

-- Delete orphaned rows
DELETE FROM "stemme"
WHERE "afstemningid" NOT IN (SELECT "id" FROM "afstemning");

-- Delete orphaned rows
DELETE FROM "SagAktoer"
WHERE "sagid" NOT IN (SELECT "id" FROM "sag");
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

-- AddForeignKey
ALTER TABLE "Aktoer" ADD CONSTRAINT "Aktoer_typeid_fkey" FOREIGN KEY ("typeid") REFERENCES "Aktoertype"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Aktoer" ADD CONSTRAINT "Aktoer_periodeid_fkey" FOREIGN KEY ("periodeid") REFERENCES "periode"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AktoerAktoer" ADD CONSTRAINT "AktoerAktoer_fraaktoerid_fkey" FOREIGN KEY ("fraaktoerid") REFERENCES "Aktoer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AktoerAktoer" ADD CONSTRAINT "AktoerAktoer_tilaktoerid_fkey" FOREIGN KEY ("tilaktoerid") REFERENCES "Aktoer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AktoerAktoer" ADD CONSTRAINT "AktoerAktoer_rolleid_fkey" FOREIGN KEY ("rolleid") REFERENCES "AktoerAktoerRolle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DokumentAktoer" ADD CONSTRAINT "DokumentAktoer_aktoerid_fkey" FOREIGN KEY ("aktoerid") REFERENCES "Aktoer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DokumentAktoer" ADD CONSTRAINT "DokumentAktoer_dokumentid_fkey" FOREIGN KEY ("dokumentid") REFERENCES "dokument"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DokumentAktoer" ADD CONSTRAINT "DokumentAktoer_rolleid_fkey" FOREIGN KEY ("rolleid") REFERENCES "DokumentAktoerRolle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Moede" ADD CONSTRAINT "Moede_statusid_fkey" FOREIGN KEY ("statusid") REFERENCES "Moedestatus"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Moede" ADD CONSTRAINT "Moede_typeid_fkey" FOREIGN KEY ("typeid") REFERENCES "Moedetype"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Moede" ADD CONSTRAINT "Moede_periodeid_fkey" FOREIGN KEY ("periodeid") REFERENCES "periode"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MoedeAktoer" ADD CONSTRAINT "MoedeAktoer_aktoerid_fkey" FOREIGN KEY ("aktoerid") REFERENCES "Aktoer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MoedeAktoer" ADD CONSTRAINT "MoedeAktoer_moedeid_fkey" FOREIGN KEY ("moedeid") REFERENCES "Moede"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SagAktoer" ADD CONSTRAINT "SagAktoer_aktoerid_fkey" FOREIGN KEY ("aktoerid") REFERENCES "Aktoer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SagAktoer" ADD CONSTRAINT "SagAktoer_sagid_fkey" FOREIGN KEY ("sagid") REFERENCES "sag"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SagAktoer" ADD CONSTRAINT "SagAktoer_rolleid_fkey" FOREIGN KEY ("rolleid") REFERENCES "SagAktoerRolle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SagstrinAktoer" ADD CONSTRAINT "SagstrinAktoer_aktoerid_fkey" FOREIGN KEY ("aktoerid") REFERENCES "Aktoer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SagstrinAktoer" ADD CONSTRAINT "SagstrinAktoer_sagstrinid_fkey" FOREIGN KEY ("sagstrinid") REFERENCES "sagstrin"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SagstrinAktoer" ADD CONSTRAINT "SagstrinAktoer_rolleid_fkey" FOREIGN KEY ("rolleid") REFERENCES "SagstrinAktoerRolle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "afstemning" ADD CONSTRAINT "Afstemning_Afstemningstype_fkey" FOREIGN KEY ("typeid") REFERENCES "afstemningstype"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "afstemning" ADD CONSTRAINT "Afstemning_Moede_fkey" FOREIGN KEY ("moedeid") REFERENCES "Moede"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "afstemning" ADD CONSTRAINT "Afstemning_Sagstrin_fkey" FOREIGN KEY ("sagstrinid") REFERENCES "sagstrin"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dagsordenspunkt" ADD CONSTRAINT "dagsordenspunkt_superid_fkey" FOREIGN KEY ("superid") REFERENCES "dagsordenspunkt"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dagsordenspunkt" ADD CONSTRAINT "dagsordenspunkt_moedeid_fkey" FOREIGN KEY ("moedeid") REFERENCES "Moede"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dagsordenspunkt" ADD CONSTRAINT "dagsordenspunkt_sagstrinid_fkey" FOREIGN KEY ("sagstrinid") REFERENCES "sagstrin"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dagsordenspunktdokument" ADD CONSTRAINT "dagsordenspunktdokument_dagsordenspunktid_fkey" FOREIGN KEY ("dagsordenspunktid") REFERENCES "dagsordenspunkt"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dagsordenspunktdokument" ADD CONSTRAINT "dagsordenspunktdokument_dokumentid_fkey" FOREIGN KEY ("dokumentid") REFERENCES "dokument"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dagsordenspunktsag" ADD CONSTRAINT "dagsordenspunktsag_dagsordenspunktid_fkey" FOREIGN KEY ("dagsordenspunktid") REFERENCES "dagsordenspunkt"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dagsordenspunktsag" ADD CONSTRAINT "dagsordenspunktsag_sagid_fkey" FOREIGN KEY ("sagid") REFERENCES "sag"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dokument" ADD CONSTRAINT "dokument_spoergsmaalsid_fkey" FOREIGN KEY ("spoergsmaalsid") REFERENCES "dokument"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dokument" ADD CONSTRAINT "dokument_kategoriid_fkey" FOREIGN KEY ("kategoriid") REFERENCES "dokumentkategori"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dokument" ADD CONSTRAINT "dokument_statusid_fkey" FOREIGN KEY ("statusid") REFERENCES "dokumentstatus"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dokument" ADD CONSTRAINT "dokument_typeid_fkey" FOREIGN KEY ("typeid") REFERENCES "dokumenttype"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "emneord" ADD CONSTRAINT "emneord_typeid_fkey" FOREIGN KEY ("typeid") REFERENCES "emneordstype"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "emneorddokument" ADD CONSTRAINT "emneorddokument_dokumentid_fkey" FOREIGN KEY ("dokumentid") REFERENCES "dokument"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "emneorddokument" ADD CONSTRAINT "emneorddokument_emneordid_fkey" FOREIGN KEY ("emneordid") REFERENCES "emneord"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "emneordsag" ADD CONSTRAINT "emneordsag_emneordid_fkey" FOREIGN KEY ("emneordid") REFERENCES "emneord"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "emneordsag" ADD CONSTRAINT "emneordsag_sagid_fkey" FOREIGN KEY ("sagid") REFERENCES "sag"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fil" ADD CONSTRAINT "fil_dokumentid_fkey" FOREIGN KEY ("dokumentid") REFERENCES "dokument"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "omtryk" ADD CONSTRAINT "omtryk_dokumentid_fkey" FOREIGN KEY ("dokumentid") REFERENCES "dokument"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sag" ADD CONSTRAINT "sag_deltundersagid_fkey" FOREIGN KEY ("deltundersagid") REFERENCES "sag"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sag" ADD CONSTRAINT "sag_fremsatundersagid_fkey" FOREIGN KEY ("fremsatundersagid") REFERENCES "sag"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sag" ADD CONSTRAINT "sag_periodeid_fkey" FOREIGN KEY ("periodeid") REFERENCES "periode"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sag" ADD CONSTRAINT "sag_kategoriid_fkey" FOREIGN KEY ("kategoriid") REFERENCES "sagskategori"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sag" ADD CONSTRAINT "sag_statusid_fkey" FOREIGN KEY ("statusid") REFERENCES "sagsstatus"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sag" ADD CONSTRAINT "sag_typeid_fkey" FOREIGN KEY ("typeid") REFERENCES "sagstype"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sagdokument" ADD CONSTRAINT "sagdokument_dokumentid_fkey" FOREIGN KEY ("dokumentid") REFERENCES "dokument"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sagdokument" ADD CONSTRAINT "sagdokument_sagid_fkey" FOREIGN KEY ("sagid") REFERENCES "sag"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sagdokument" ADD CONSTRAINT "sagdokument_rolleid_fkey" FOREIGN KEY ("rolleid") REFERENCES "sagdokumentrolle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sagstrin" ADD CONSTRAINT "sagstrin_sagid_fkey" FOREIGN KEY ("sagid") REFERENCES "sag"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sagstrin" ADD CONSTRAINT "sagstrin_statusid_fkey" FOREIGN KEY ("statusid") REFERENCES "sagstrinsstatus"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sagstrin" ADD CONSTRAINT "sagstrin_typeid_fkey" FOREIGN KEY ("typeid") REFERENCES "sagstrinstype"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sagstrindokument" ADD CONSTRAINT "SagsstrinDokument_Dokument_fkey" FOREIGN KEY ("dokumentid") REFERENCES "dokument"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sagstrindokument" ADD CONSTRAINT "SagstrinDokument_Sagstrin_fkey" FOREIGN KEY ("sagstrinid") REFERENCES "sagstrin"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sambehandlinger" ADD CONSTRAINT "sambehandlinger_foerstesagstrinid_fkey" FOREIGN KEY ("foerstesagstrinid") REFERENCES "sagstrin"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sambehandlinger" ADD CONSTRAINT "sambehandlinger_andetsagstrinid_fkey" FOREIGN KEY ("andetsagstrinid") REFERENCES "sagstrin"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stemme" ADD CONSTRAINT "stemme_afstemningid_fkey" FOREIGN KEY ("afstemningid") REFERENCES "afstemning"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stemme" ADD CONSTRAINT "stemme_aktoerid_fkey" FOREIGN KEY ("aktoerid") REFERENCES "Aktoer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

/*
  Warnings:

  - You are about to drop the column `afgorelse` on the `Sag` table. All the data in the column will be lost.
  - You are about to drop the `Answers` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Question` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Quiz` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `QuizResults` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Answers" DROP CONSTRAINT "Answers_questionId_fkey";

-- DropForeignKey
ALTER TABLE "QuizResults" DROP CONSTRAINT "QuizResults_quizId_fkey";

-- AlterTable
CREATE SEQUENCE sag_id_seq;
ALTER TABLE "Sag" DROP COLUMN "afgorelse",
ADD COLUMN     "afgoerelse" TEXT,
ADD COLUMN     "raadsmoededato" TIMESTAMP(3),
ALTER COLUMN "id" SET DEFAULT nextval('sag_id_seq'),
ALTER COLUMN "statsbudgetsag" DROP NOT NULL;
ALTER SEQUENCE sag_id_seq OWNED BY "Sag"."id";

-- DropTable
DROP TABLE "Answers";

-- DropTable
DROP TABLE "Question";

-- DropTable
DROP TABLE "Quiz";

-- DropTable
DROP TABLE "QuizResults";

-- CreateTable
CREATE TABLE "Afstemning" (
    "id" SERIAL NOT NULL,
    "nummer" INTEGER NOT NULL,
    "konklusion" TEXT,
    "vedtaget" BOOLEAN NOT NULL,
    "kommentar" TEXT,
    "moedeid" INTEGER NOT NULL,
    "typeid" INTEGER NOT NULL,
    "sagstrinid" INTEGER,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Afstemning_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Afstemningstype" (
    "id" SERIAL NOT NULL,
    "type" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Afstemningstype_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Aktstykke" (
    "id" SERIAL NOT NULL,
    "typeid" INTEGER NOT NULL,
    "kategoriid" INTEGER,
    "statusid" INTEGER NOT NULL,
    "titel" TEXT,
    "titelkort" TEXT,
    "offentlighedskode" TEXT,
    "nummer" TEXT,
    "nummerprefix" TEXT,
    "nummernumerisk" TEXT,
    "nummerpostfix" TEXT,
    "resume" TEXT,
    "afstemningskonklusion" TEXT,
    "periodeid" INTEGER NOT NULL,
    "afgoerelsesresultatkode" TEXT,
    "baggrundsmateriale" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,
    "statsbudgetsag" BOOLEAN,
    "begrundelse" TEXT,
    "paragrafnummer" INTEGER,
    "paragraf" TEXT,
    "afgoerelsesdato" TIMESTAMP(3),
    "afgoerelse" TEXT,
    "raadsmoededato" TIMESTAMP(3),
    "lovnummer" TEXT,
    "lovnummerdato" TIMESTAMP(3),
    "retsinformationsurl" TEXT,
    "fremsatundersagid" INTEGER,
    "deltundersagid" INTEGER,

    CONSTRAINT "Aktstykke_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Aktoer" (
    "id" SERIAL NOT NULL,
    "typeid" INTEGER NOT NULL,
    "gruppenavnkort" TEXT,
    "navn" TEXT,
    "fornavn" TEXT,
    "efternavn" TEXT,
    "biografi" TEXT,
    "periodeid" INTEGER,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,
    "startdato" TIMESTAMP(3),
    "slutdato" TIMESTAMP(3),

    CONSTRAINT "Aktoer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AktoerAktoer" (
    "id" SERIAL NOT NULL,
    "fraaktoerid" INTEGER NOT NULL,
    "tilaktoerid" INTEGER NOT NULL,
    "startdato" TIMESTAMP(3),
    "slutdato" TIMESTAMP(3),
    "opdateringsdato" TIMESTAMP(3) NOT NULL,
    "rolleid" INTEGER,

    CONSTRAINT "AktoerAktoer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AktoerAktoerRolle" (
    "id" SERIAL NOT NULL,
    "rolle" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AktoerAktoerRolle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Aktoertype" (
    "id" SERIAL NOT NULL,
    "type" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Aktoertype_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Almdel" (
    "id" SERIAL NOT NULL,
    "typeid" INTEGER NOT NULL,
    "kategoriid" INTEGER,
    "statusid" INTEGER NOT NULL,
    "titel" TEXT,
    "titelkort" TEXT,
    "offentlighedskode" TEXT,
    "nummer" TEXT,
    "nummerprefix" TEXT,
    "nummernumerisk" TEXT,
    "nummerpostfix" TEXT,
    "resume" TEXT,
    "afstemningskonklusion" TEXT,
    "periodeid" INTEGER NOT NULL,
    "afgoerelsesresultatkode" TEXT,
    "baggrundsmateriale" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,
    "statsbudgetsag" BOOLEAN,
    "begrundelse" TEXT,
    "paragrafnummer" INTEGER,
    "paragraf" TEXT,
    "afgoerelsesdato" TIMESTAMP(3),
    "afgoerelse" TEXT,
    "raadsmoededato" TIMESTAMP(3),
    "lovnummer" TEXT,
    "lovnummerdato" TIMESTAMP(3),
    "retsinformationsurl" TEXT,
    "fremsatundersagid" INTEGER,
    "deltundersagid" INTEGER,

    CONSTRAINT "Almdel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Dagsordenspunkt" (
    "id" SERIAL NOT NULL,
    "koerebemaerkning" TEXT,
    "titel" TEXT,
    "kommentar" TEXT,
    "nummer" TEXT,
    "forhandlingskode" TEXT,
    "forhandling" TEXT,
    "superid" INTEGER,
    "sagstrinid" INTEGER,
    "moedeid" INTEGER NOT NULL,
    "offentlighedskode" TEXT,
    "opdateringsdato" TIMESTAMP(3),

    CONSTRAINT "Dagsordenspunkt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DagsordenspunktDokument" (
    "id" SERIAL NOT NULL,
    "dokumentid" INTEGER NOT NULL,
    "dagsordenspunktid" INTEGER NOT NULL,
    "note" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DagsordenspunktDokument_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DagsordenspunktSag" (
    "id" SERIAL NOT NULL,
    "dagsordenspunktid" INTEGER NOT NULL,
    "sagid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DagsordenspunktSag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Debat" (
    "id" SERIAL NOT NULL,
    "typeid" INTEGER NOT NULL,
    "kategoriid" INTEGER,
    "statusid" INTEGER NOT NULL,
    "titel" TEXT,
    "titelkort" TEXT,
    "offentlighedskode" TEXT,
    "nummer" TEXT,
    "nummerprefix" TEXT,
    "nummernumerisk" TEXT,
    "nummerpostfix" TEXT,
    "resume" TEXT,
    "afstemningskonklusion" TEXT,
    "periodeid" INTEGER NOT NULL,
    "afgoerelsesresultatkode" TEXT,
    "baggrundsmateriale" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,
    "statsbudgetsag" BOOLEAN,
    "begrundelse" TEXT,
    "paragrafnummer" INTEGER,
    "paragraf" TEXT,
    "afgoerelsesdato" TIMESTAMP(3),
    "afgoerelse" TEXT,
    "raadsmoededato" TIMESTAMP(3),
    "lovnummer" TEXT,
    "lovnummerdato" TIMESTAMP(3),
    "retsinformationsurl" TEXT,
    "fremsatundersagid" INTEGER,
    "deltundersagid" INTEGER,

    CONSTRAINT "Debat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Dokument" (
    "id" SERIAL NOT NULL,
    "typeid" INTEGER NOT NULL,
    "kategoriid" INTEGER NOT NULL,
    "statusid" INTEGER NOT NULL,
    "offentlighedskode" TEXT,
    "titel" TEXT,
    "dato" TIMESTAMP(3) NOT NULL,
    "modtagelsesdato" TIMESTAMP(3),
    "frigivelsesdato" TIMESTAMP(3),
    "paragraf" TEXT,
    "paragrafnummer" TEXT,
    "spoergsmaalsordlyd" TEXT,
    "spoergsmaalstitel" TEXT,
    "spoergsmaalsid" INTEGER,
    "procedurenummer" TEXT,
    "grundnotatstatus" TEXT,
    "dagsordenudgavenummer" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Dokument_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DokumentAktoer" (
    "id" SERIAL NOT NULL,
    "dokumentid" INTEGER NOT NULL,
    "aktoerid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,
    "rolleid" INTEGER NOT NULL,

    CONSTRAINT "DokumentAktoer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DokumentAktoerRolle" (
    "id" SERIAL NOT NULL,
    "rolle" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DokumentAktoerRolle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Dokumentkategori" (
    "id" SERIAL NOT NULL,
    "kategori" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Dokumentkategori_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Dokumenttype" (
    "id" SERIAL NOT NULL,
    "type" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Dokumenttype_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Dokumentstatus" (
    "id" SERIAL NOT NULL,
    "status" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Dokumentstatus_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Emneord" (
    "id" SERIAL NOT NULL,
    "typeid" INTEGER NOT NULL,
    "emneord" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Emneord_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EmneordDokument" (
    "id" SERIAL NOT NULL,
    "emneordid" INTEGER NOT NULL,
    "dokumentid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "EmneordDokument_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EmneordSag" (
    "id" SERIAL NOT NULL,
    "emneordid" INTEGER NOT NULL,
    "sagid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "EmneordSag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Emneordstype" (
    "id" SERIAL NOT NULL,
    "type" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Emneordstype_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EUsag" (
    "id" SERIAL NOT NULL,
    "typeid" INTEGER NOT NULL,
    "kategoriid" INTEGER,
    "statusid" INTEGER NOT NULL,
    "titel" TEXT,
    "titelkort" TEXT,
    "offentlighedskode" TEXT,
    "nummer" TEXT,
    "nummerprefix" TEXT,
    "nummernumerisk" TEXT,
    "nummerpostfix" TEXT,
    "resume" TEXT,
    "afstemningskonklusion" TEXT,
    "periodeid" INTEGER NOT NULL,
    "afgoerelsesresultatkode" TEXT,
    "baggrundsmateriale" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,
    "statsbudgetsag" BOOLEAN,
    "begrundelse" TEXT,
    "paragrafnummer" INTEGER,
    "paragraf" TEXT,
    "afgoerelsesdato" TIMESTAMP(3),
    "afgoerelse" TEXT,
    "raadsmoededato" TIMESTAMP(3),
    "lovnummer" TEXT,
    "lovnummerdato" TIMESTAMP(3),
    "retsinformationsurl" TEXT,
    "fremsatundersagid" INTEGER,
    "deltundersagid" INTEGER,

    CONSTRAINT "EUsag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Forslag" (
    "id" SERIAL NOT NULL,
    "typeid" INTEGER NOT NULL,
    "kategoriid" INTEGER,
    "statusid" INTEGER NOT NULL,
    "titel" TEXT,
    "titelkort" TEXT,
    "offentlighedskode" TEXT,
    "nummer" TEXT,
    "nummerprefix" TEXT,
    "nummernumerisk" TEXT,
    "nummerpostfix" TEXT,
    "resume" TEXT,
    "afstemningskonklusion" TEXT,
    "periodeid" INTEGER NOT NULL,
    "afgoerelsesresultatkode" TEXT,
    "baggrundsmateriale" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,
    "statsbudgetsag" BOOLEAN,
    "begrundelse" TEXT,
    "paragrafnummer" INTEGER,
    "paragraf" TEXT,
    "afgoerelsesdato" TIMESTAMP(3),
    "afgoerelse" TEXT,
    "raadsmoededato" TIMESTAMP(3),
    "lovnummer" TEXT,
    "lovnummerdato" TIMESTAMP(3),
    "retsinformationsurl" TEXT,
    "fremsatundersagid" INTEGER,
    "deltundersagid" INTEGER,

    CONSTRAINT "Forslag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Fil" (
    "id" SERIAL NOT NULL,
    "dokumentid" INTEGER NOT NULL,
    "titel" TEXT,
    "versionsdato" TIMESTAMP(3) NOT NULL,
    "filurl" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,
    "variantkode" TEXT,
    "format" TEXT,

    CONSTRAINT "Fil_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "KolloneBeskrivelse" (
    "id" SERIAL NOT NULL,
    "entitetnavn" TEXT,
    "kollonenavn" TEXT,
    "beskrivelse" TEXT,
    "opdateringsdato" TIMESTAMP(3),

    CONSTRAINT "KolloneBeskrivelse_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EntitetBeskrivelse" (
    "id" SERIAL NOT NULL,
    "entitetnavn" TEXT,
    "beskrivelse" TEXT,
    "opdateringsdato" TIMESTAMP(3),

    CONSTRAINT "EntitetBeskrivelse_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Moede" (
    "id" SERIAL NOT NULL,
    "titel" TEXT,
    "lokale" TEXT,
    "nummer" TEXT,
    "dagsordenurl" TEXT,
    "starttidsbemaerkning" TEXT,
    "offentlighedskode" TEXT,
    "dato" TIMESTAMP(3),
    "statusid" INTEGER,
    "typeid" INTEGER,
    "periodeid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Moede_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MoedeAktoer" (
    "id" SERIAL NOT NULL,
    "moedeid" INTEGER NOT NULL,
    "aktoerid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "MoedeAktoer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Moedestatus" (
    "id" SERIAL NOT NULL,
    "status" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Moedestatus_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Moedetype" (
    "id" SERIAL NOT NULL,
    "type" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Moedetype_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Omtryk" (
    "id" SERIAL NOT NULL,
    "dokumentid" INTEGER NOT NULL,
    "dato" TIMESTAMP(3),
    "begrundelse" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Omtryk_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Periode" (
    "id" SERIAL NOT NULL,
    "startdato" TIMESTAMP(3) NOT NULL,
    "slutdato" TIMESTAMP(3) NOT NULL,
    "type" TEXT,
    "kode" TEXT,
    "titel" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Periode_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SagAktoer" (
    "id" SERIAL NOT NULL,
    "aktoerid" INTEGER NOT NULL,
    "sagid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,
    "rolleid" INTEGER NOT NULL,

    CONSTRAINT "SagAktoer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SagAktoerRolle" (
    "id" SERIAL NOT NULL,
    "rolle" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SagAktoerRolle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SagDokument" (
    "id" SERIAL NOT NULL,
    "sagid" INTEGER NOT NULL,
    "dokumentid" INTEGER NOT NULL,
    "bilagsnummer" TEXT,
    "frigivelsesdato" TIMESTAMP(3),
    "opdateringsdato" TIMESTAMP(3) NOT NULL,
    "rolleid" INTEGER NOT NULL,

    CONSTRAINT "SagDokument_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SagDokumentRolle" (
    "id" SERIAL NOT NULL,
    "rolle" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SagDokumentRolle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Sagskategori" (
    "id" SERIAL NOT NULL,
    "kategori" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Sagskategori_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Sagsstatus" (
    "id" SERIAL NOT NULL,
    "status" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Sagsstatus_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Sagstrin" (
    "id" SERIAL NOT NULL,
    "titel" TEXT,
    "dato" TIMESTAMP(3),
    "sagid" INTEGER NOT NULL,
    "typeid" INTEGER NOT NULL,
    "folketingstidendeurl" TEXT,
    "folketingstidende" TEXT,
    "folketingstidendesidenummer" TEXT,
    "statusid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Sagstrin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SagstrinAktoer" (
    "id" SERIAL NOT NULL,
    "sagstrinid" INTEGER NOT NULL,
    "aktoerid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,
    "rolleid" INTEGER NOT NULL,

    CONSTRAINT "SagstrinAktoer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SagstrinAktoerRolle" (
    "id" SERIAL NOT NULL,
    "rolle" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SagstrinAktoerRolle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Sambehandlinger" (
    "id" SERIAL NOT NULL,
    "foerstesagstrinid" INTEGER NOT NULL,
    "andetsagstrinid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Sambehandlinger_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SagstrinDokument" (
    "id" SERIAL NOT NULL,
    "sagstrinid" INTEGER NOT NULL,
    "dokumentid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SagstrinDokument_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Sagstrinsstatus" (
    "id" SERIAL NOT NULL,
    "status" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Sagstrinsstatus_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Sagstrinstype" (
    "id" SERIAL NOT NULL,
    "type" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Sagstrinstype_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Sagstype" (
    "id" SERIAL NOT NULL,
    "type" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Sagstype_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Stemme" (
    "id" SERIAL NOT NULL,
    "typeid" INTEGER,
    "afstemningid" INTEGER NOT NULL,
    "aktoerid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Stemme_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Stemmetype" (
    "id" SERIAL NOT NULL,
    "type" TEXT,
    "opdateringsdato" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Stemmetype_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Afstemning" ADD CONSTRAINT "Afstemning_Afstemningstype_fkey" FOREIGN KEY ("typeid") REFERENCES "Afstemningstype"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Afstemning" ADD CONSTRAINT "Afstemning_Moede_fkey" FOREIGN KEY ("moedeid") REFERENCES "Moede"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Afstemning" ADD CONSTRAINT "Afstemning_Sagstrin_fkey" FOREIGN KEY ("sagstrinid") REFERENCES "Sagstrin"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Aktoer" ADD CONSTRAINT "Aktoer_typeid_fkey" FOREIGN KEY ("typeid") REFERENCES "Aktoertype"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Aktoer" ADD CONSTRAINT "Aktoer_periodeid_fkey" FOREIGN KEY ("periodeid") REFERENCES "Periode"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AktoerAktoer" ADD CONSTRAINT "AktoerAktoer_fraaktoerid_fkey" FOREIGN KEY ("fraaktoerid") REFERENCES "Aktoer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AktoerAktoer" ADD CONSTRAINT "AktoerAktoer_tilaktoerid_fkey" FOREIGN KEY ("tilaktoerid") REFERENCES "Aktoer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AktoerAktoer" ADD CONSTRAINT "AktoerAktoer_rolleid_fkey" FOREIGN KEY ("rolleid") REFERENCES "AktoerAktoerRolle"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Dagsordenspunkt" ADD CONSTRAINT "Dagsordenspunkt_superid_fkey" FOREIGN KEY ("superid") REFERENCES "Dagsordenspunkt"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Dagsordenspunkt" ADD CONSTRAINT "Dagsordenspunkt_moedeid_fkey" FOREIGN KEY ("moedeid") REFERENCES "Moede"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Dagsordenspunkt" ADD CONSTRAINT "Dagsordenspunkt_sagstrinid_fkey" FOREIGN KEY ("sagstrinid") REFERENCES "Sagstrin"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DagsordenspunktDokument" ADD CONSTRAINT "DagsordenspunktDokument_dagsordenspunktid_fkey" FOREIGN KEY ("dagsordenspunktid") REFERENCES "Dagsordenspunkt"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DagsordenspunktDokument" ADD CONSTRAINT "DagsordenspunktDokument_dokumentid_fkey" FOREIGN KEY ("dokumentid") REFERENCES "Dokument"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DagsordenspunktSag" ADD CONSTRAINT "DagsordenspunktSag_dagsordenspunktid_fkey" FOREIGN KEY ("dagsordenspunktid") REFERENCES "Dagsordenspunkt"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DagsordenspunktSag" ADD CONSTRAINT "DagsordenspunktSag_sagid_fkey" FOREIGN KEY ("sagid") REFERENCES "Sag"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Dokument" ADD CONSTRAINT "Dokument_spoergsmaalsid_fkey" FOREIGN KEY ("spoergsmaalsid") REFERENCES "Dokument"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Dokument" ADD CONSTRAINT "Dokument_kategoriid_fkey" FOREIGN KEY ("kategoriid") REFERENCES "Dokumentkategori"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Dokument" ADD CONSTRAINT "Dokument_statusid_fkey" FOREIGN KEY ("statusid") REFERENCES "Dokumentstatus"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Dokument" ADD CONSTRAINT "Dokument_typeid_fkey" FOREIGN KEY ("typeid") REFERENCES "Dokumenttype"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DokumentAktoer" ADD CONSTRAINT "DokumentAktoer_aktoerid_fkey" FOREIGN KEY ("aktoerid") REFERENCES "Aktoer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DokumentAktoer" ADD CONSTRAINT "DokumentAktoer_dokumentid_fkey" FOREIGN KEY ("dokumentid") REFERENCES "Dokument"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DokumentAktoer" ADD CONSTRAINT "DokumentAktoer_rolleid_fkey" FOREIGN KEY ("rolleid") REFERENCES "DokumentAktoerRolle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Emneord" ADD CONSTRAINT "Emneord_typeid_fkey" FOREIGN KEY ("typeid") REFERENCES "Emneordstype"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmneordDokument" ADD CONSTRAINT "EmneordDokument_dokumentid_fkey" FOREIGN KEY ("dokumentid") REFERENCES "Dokument"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmneordDokument" ADD CONSTRAINT "EmneordDokument_emneordid_fkey" FOREIGN KEY ("emneordid") REFERENCES "Emneord"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmneordSag" ADD CONSTRAINT "EmneordSag_emneordid_fkey" FOREIGN KEY ("emneordid") REFERENCES "Emneord"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmneordSag" ADD CONSTRAINT "EmneordSag_sagid_fkey" FOREIGN KEY ("sagid") REFERENCES "Sag"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Fil" ADD CONSTRAINT "Fil_dokumentid_fkey" FOREIGN KEY ("dokumentid") REFERENCES "Dokument"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Moede" ADD CONSTRAINT "Moede_statusid_fkey" FOREIGN KEY ("statusid") REFERENCES "Moedestatus"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Moede" ADD CONSTRAINT "Moede_typeid_fkey" FOREIGN KEY ("typeid") REFERENCES "Moedetype"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Moede" ADD CONSTRAINT "Moede_periodeid_fkey" FOREIGN KEY ("periodeid") REFERENCES "Periode"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MoedeAktoer" ADD CONSTRAINT "MoedeAktoer_aktoerid_fkey" FOREIGN KEY ("aktoerid") REFERENCES "Aktoer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MoedeAktoer" ADD CONSTRAINT "MoedeAktoer_moedeid_fkey" FOREIGN KEY ("moedeid") REFERENCES "Moede"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Omtryk" ADD CONSTRAINT "Omtryk_dokumentid_fkey" FOREIGN KEY ("dokumentid") REFERENCES "Dokument"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sag" ADD CONSTRAINT "Sag_deltundersagid_fkey" FOREIGN KEY ("deltundersagid") REFERENCES "Sag"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sag" ADD CONSTRAINT "Sag_fremsatundersagid_fkey" FOREIGN KEY ("fremsatundersagid") REFERENCES "Sag"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sag" ADD CONSTRAINT "Sag_periodeid_fkey" FOREIGN KEY ("periodeid") REFERENCES "Periode"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sag" ADD CONSTRAINT "Sag_kategoriid_fkey" FOREIGN KEY ("kategoriid") REFERENCES "Sagskategori"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sag" ADD CONSTRAINT "Sag_statusid_fkey" FOREIGN KEY ("statusid") REFERENCES "Sagsstatus"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sag" ADD CONSTRAINT "Sag_typeid_fkey" FOREIGN KEY ("typeid") REFERENCES "Sagstype"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SagAktoer" ADD CONSTRAINT "SagAktoer_aktoerid_fkey" FOREIGN KEY ("aktoerid") REFERENCES "Aktoer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SagAktoer" ADD CONSTRAINT "SagAktoer_sagid_fkey" FOREIGN KEY ("sagid") REFERENCES "Sag"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SagAktoer" ADD CONSTRAINT "SagAktoer_rolleid_fkey" FOREIGN KEY ("rolleid") REFERENCES "SagAktoerRolle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SagDokument" ADD CONSTRAINT "SagDokument_dokumentid_fkey" FOREIGN KEY ("dokumentid") REFERENCES "Dokument"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SagDokument" ADD CONSTRAINT "SagDokument_sagid_fkey" FOREIGN KEY ("sagid") REFERENCES "Sag"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SagDokument" ADD CONSTRAINT "SagDokument_rolleid_fkey" FOREIGN KEY ("rolleid") REFERENCES "SagDokumentRolle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sagstrin" ADD CONSTRAINT "Sagstrin_sagid_fkey" FOREIGN KEY ("sagid") REFERENCES "Sag"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sagstrin" ADD CONSTRAINT "Sagstrin_statusid_fkey" FOREIGN KEY ("statusid") REFERENCES "Sagstrinsstatus"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sagstrin" ADD CONSTRAINT "Sagstrin_typeid_fkey" FOREIGN KEY ("typeid") REFERENCES "Sagstrinstype"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SagstrinAktoer" ADD CONSTRAINT "SagstrinAktoer_aktoerid_fkey" FOREIGN KEY ("aktoerid") REFERENCES "Aktoer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SagstrinAktoer" ADD CONSTRAINT "SagstrinAktoer_sagstrinid_fkey" FOREIGN KEY ("sagstrinid") REFERENCES "Sagstrin"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SagstrinAktoer" ADD CONSTRAINT "SagstrinAktoer_rolleid_fkey" FOREIGN KEY ("rolleid") REFERENCES "SagstrinAktoerRolle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sambehandlinger" ADD CONSTRAINT "Sambehandlinger_foerstesagstrinid_fkey" FOREIGN KEY ("foerstesagstrinid") REFERENCES "Sagstrin"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sambehandlinger" ADD CONSTRAINT "Sambehandlinger_andetsagstrinid_fkey" FOREIGN KEY ("andetsagstrinid") REFERENCES "Sagstrin"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SagstrinDokument" ADD CONSTRAINT "SagsstrinDokument_Dokument_fkey" FOREIGN KEY ("dokumentid") REFERENCES "Dokument"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SagstrinDokument" ADD CONSTRAINT "SagstrinDokument_Sagstrin_fkey" FOREIGN KEY ("sagstrinid") REFERENCES "Sagstrin"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Stemme" ADD CONSTRAINT "Stemme_afstemningid_fkey" FOREIGN KEY ("afstemningid") REFERENCES "Afstemning"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Stemme" ADD CONSTRAINT "Stemme_aktoerid_fkey" FOREIGN KEY ("aktoerid") REFERENCES "Aktoer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Stemme" ADD CONSTRAINT "Stemme_typeid_fkey" FOREIGN KEY ("typeid") REFERENCES "Stemmetype"("id") ON DELETE SET NULL ON UPDATE CASCADE;

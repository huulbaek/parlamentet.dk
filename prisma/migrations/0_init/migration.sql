-- CreateTable
CREATE TABLE "Aktoer" (
    "id" INTEGER NOT NULL,
    "typeid" INTEGER NOT NULL,
    "gruppenavnkort" TEXT,
    "navn" TEXT,
    "fornavn" TEXT,
    "efternavn" TEXT,
    "biografi" TEXT,
    "periodeid" INTEGER,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,
    "startdato" TIMESTAMPTZ(6),
    "slutdato" TIMESTAMPTZ(6),

    CONSTRAINT "idx_109161_PK_Aktør" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AktoerAktoer" (
    "id" BIGSERIAL NOT NULL,
    "fraaktoerid" INTEGER NOT NULL,
    "tilaktoerid" INTEGER NOT NULL,
    "startdato" TIMESTAMPTZ(6),
    "slutdato" TIMESTAMPTZ(6),
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,
    "rolleid" INTEGER NOT NULL,

    CONSTRAINT "idx_109167_PK_AktørAktør" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AktoerAktoerRolle" (
    "id" INTEGER NOT NULL,
    "rolle" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109171_PK_AktørAktørRolle" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Aktoertype" (
    "id" INTEGER NOT NULL,
    "type" TEXT,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109176_PK_Aktørtype" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DokumentAktoer" (
    "id" BIGSERIAL NOT NULL,
    "dokumentid" INTEGER NOT NULL,
    "aktoerid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,
    "rolleid" INTEGER NOT NULL,

    CONSTRAINT "idx_109204_PK_DokumentAktør" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DokumentAktoerRolle" (
    "id" INTEGER NOT NULL,
    "rolle" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109208_PK_DokumentAktørRolle" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Moede" (
    "id" INTEGER NOT NULL,
    "titel" TEXT NOT NULL,
    "lokale" TEXT,
    "nummer" TEXT,
    "dagsordenurl" TEXT,
    "starttidsbemaerkning" TEXT,
    "offentlighedskode" TEXT NOT NULL,
    "dato" TIMESTAMPTZ(6),
    "statusid" INTEGER,
    "typeid" INTEGER,
    "periodeid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109272_PK_Møde" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MoedeAktoer" (
    "id" BIGSERIAL NOT NULL,
    "moedeid" INTEGER NOT NULL,
    "aktoerid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109278_PK_MødeAktør" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Moedestatus" (
    "id" INTEGER NOT NULL,
    "status" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109282_PK_Mødestatus" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Moedetype" (
    "id" INTEGER NOT NULL,
    "type" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109287_PK_Mødetype" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SagAktoer" (
    "id" BIGSERIAL NOT NULL,
    "aktoerid" INTEGER NOT NULL,
    "sagid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,
    "rolleid" INTEGER NOT NULL,

    CONSTRAINT "idx_109308_PK_Sagaktør" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SagAktoerRolle" (
    "id" INTEGER NOT NULL,
    "rolle" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109312_PK_SagAktørRolle" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SagstrinAktoer" (
    "id" BIGSERIAL NOT NULL,
    "sagstrinid" INTEGER NOT NULL,
    "aktoerid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,
    "rolleid" INTEGER NOT NULL,

    CONSTRAINT "idx_109345_PK_Sagstrinaktør" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SagstrinAktoerRolle" (
    "id" INTEGER NOT NULL,
    "rolle" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109349_PK_SagstrinAktørRolle" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "__refactorlog" (
    "operationkey" UUID NOT NULL,

    CONSTRAINT "idx_109148_pk____refact__d3aeffdbad8cba18" PRIMARY KEY ("operationkey")
);

-- CreateTable
CREATE TABLE "afstemning" (
    "id" INTEGER NOT NULL,
    "nummer" INTEGER NOT NULL,
    "konklusion" TEXT,
    "vedtaget" BOOLEAN NOT NULL,
    "kommentar" TEXT,
    "moedeid" INTEGER NOT NULL,
    "typeid" INTEGER NOT NULL,
    "sagstrinid" INTEGER,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109151_pk_afstemning" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "afstemningstype" (
    "id" INTEGER NOT NULL,
    "type" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109156_pk_afstemningstype" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dagsordenspunkt" (
    "id" INTEGER NOT NULL,
    "koerebemaerkning" TEXT,
    "titel" TEXT,
    "kommentar" TEXT,
    "nummer" TEXT,
    "forhandlingskode" TEXT,
    "forhandling" TEXT,
    "superid" INTEGER,
    "sagstrinid" INTEGER,
    "moedeid" INTEGER NOT NULL,
    "offentlighedskode" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6),

    CONSTRAINT "idx_109181_pk_dagsordenspunkt" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dagsordenspunktdokument" (
    "id" BIGSERIAL NOT NULL,
    "dokumentid" INTEGER NOT NULL,
    "dagsordenspunktid" INTEGER NOT NULL,
    "note" TEXT,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109187_pk_dagsordenspunktdokument" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dagsordenspunktsag" (
    "id" BIGSERIAL NOT NULL,
    "dagsordenspunktid" INTEGER NOT NULL,
    "sagid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109194_pk_dagsordenspunktsag" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dokument" (
    "id" INTEGER NOT NULL,
    "typeid" INTEGER NOT NULL,
    "kategoriid" INTEGER NOT NULL,
    "statusid" INTEGER NOT NULL,
    "offentlighedskode" TEXT NOT NULL,
    "titel" TEXT NOT NULL,
    "dato" TIMESTAMPTZ(6) NOT NULL,
    "modtagelsesdato" TIMESTAMPTZ(6),
    "frigivelsesdato" TIMESTAMPTZ(6),
    "paragraf" TEXT,
    "paragrafnummer" TEXT,
    "spoergsmaalsordlyd" TEXT,
    "spoergsmaalstitel" TEXT,
    "spoergsmaalsid" INTEGER,
    "procedurenummer" TEXT,
    "grundnotatstatus" TEXT,
    "dagsordenudgavenummer" SMALLINT,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109198_pk_dokument" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dokumentkategori" (
    "id" INTEGER NOT NULL,
    "kategori" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109213_pk_dokumentkategori" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dokumentstatus" (
    "id" INTEGER NOT NULL,
    "status" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109218_pk_dokumentstatus" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dokumenttype" (
    "id" INTEGER NOT NULL,
    "type" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109223_pk_dokumenttype" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "emneord" (
    "id" INTEGER NOT NULL,
    "typeid" INTEGER NOT NULL,
    "emneord" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109228_pk_emneord" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "emneorddokument" (
    "id" BIGSERIAL NOT NULL,
    "emneordid" INTEGER NOT NULL,
    "dokumentid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109234_pk_emneorddokument" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "emneordsag" (
    "id" BIGSERIAL NOT NULL,
    "emneordid" INTEGER NOT NULL,
    "sagid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109239_pk_emneordsag" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "emneordstype" (
    "id" INTEGER NOT NULL,
    "type" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109243_pk_emneordstype" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "entitetbeskrivelse" (
    "id" BIGSERIAL NOT NULL,
    "entitetnavn" TEXT,
    "beskrivelse" TEXT,
    "opdateringsdato" TIMESTAMPTZ(6),

    CONSTRAINT "idx_109249_pk_entitetbeskrivelse" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "fil" (
    "id" INTEGER NOT NULL,
    "dokumentid" INTEGER NOT NULL,
    "titel" TEXT,
    "versionsdato" TIMESTAMPTZ(6) NOT NULL,
    "filurl" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,
    "variantkode" TEXT NOT NULL,
    "format" TEXT NOT NULL,

    CONSTRAINT "idx_109255_pk_fil" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "idmap" (
    "id" INTEGER NOT NULL,
    "originalid" TEXT NOT NULL,
    "entity" TEXT NOT NULL,

    CONSTRAINT "idx_109260_pk_idmap" PRIMARY KEY ("id","entity")
);

-- CreateTable
CREATE TABLE "kollonebeskrivelse" (
    "id" BIGSERIAL NOT NULL,
    "entitetnavn" TEXT,
    "kollonenavn" TEXT,
    "beskrivelse" TEXT,
    "opdateringsdato" TIMESTAMPTZ(6),

    CONSTRAINT "idx_109266_pk_kollonebeskrivelse" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "omtryk" (
    "id" INTEGER NOT NULL,
    "dokumentid" INTEGER NOT NULL,
    "dato" TIMESTAMPTZ(6),
    "begrundelse" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109292_pk_omtryk" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "periode" (
    "id" INTEGER NOT NULL,
    "startdato" TIMESTAMPTZ(6) NOT NULL,
    "slutdato" TIMESTAMPTZ(6) NOT NULL,
    "type" TEXT NOT NULL,
    "kode" TEXT NOT NULL,
    "titel" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109297_pk_periode" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sag" (
    "id" INTEGER NOT NULL,
    "typeid" INTEGER NOT NULL,
    "kategoriid" INTEGER,
    "statusid" INTEGER NOT NULL,
    "titel" TEXT NOT NULL,
    "titelkort" TEXT NOT NULL,
    "offentlighedskode" TEXT NOT NULL,
    "nummer" TEXT,
    "nummerprefix" TEXT,
    "nummernumerisk" TEXT,
    "nummerpostfix" TEXT,
    "resume" TEXT,
    "afstemningskonklusion" TEXT,
    "periodeid" INTEGER NOT NULL,
    "afgoerelsesresultatkode" TEXT,
    "baggrundsmateriale" TEXT,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,
    "statsbudgetsag" BOOLEAN,
    "begrundelse" TEXT,
    "paragrafnummer" INTEGER,
    "paragraf" TEXT,
    "afgoerelsesdato" TIMESTAMPTZ(6),
    "afgoerelse" TEXT,
    "raadsmoededato" TIMESTAMPTZ(6),
    "lovnummer" TEXT,
    "lovnummerdato" TIMESTAMPTZ(6),
    "retsinformationsurl" TEXT,
    "fremsatundersagid" INTEGER,
    "deltundersagid" INTEGER,

    CONSTRAINT "idx_109302_pk_sag" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sagdokument" (
    "id" BIGSERIAL NOT NULL,
    "sagid" INTEGER NOT NULL,
    "dokumentid" INTEGER NOT NULL,
    "bilagsnummer" TEXT,
    "frigivelsesdato" TIMESTAMPTZ(6),
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,
    "rolleid" INTEGER NOT NULL,

    CONSTRAINT "idx_109318_pk_sagdokument" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sagdokumentrolle" (
    "id" INTEGER NOT NULL,
    "rolle" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109324_pk_sagdokumentrolle" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sagskategori" (
    "id" INTEGER NOT NULL,
    "kategori" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109329_pk_sagskategoriset" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sagsstatus" (
    "id" INTEGER NOT NULL,
    "status" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109334_pk_sagsstatus" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sagstrin" (
    "id" INTEGER NOT NULL,
    "titel" TEXT NOT NULL,
    "dato" TIMESTAMPTZ(6),
    "sagid" INTEGER NOT NULL,
    "typeid" INTEGER NOT NULL,
    "folketingstidendeurl" TEXT,
    "folketingstidende" TEXT,
    "folketingstidendesidenummer" TEXT,
    "statusid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109339_pk_sagstrin" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sagstrindokument" (
    "id" BIGSERIAL NOT NULL,
    "sagstrinid" INTEGER NOT NULL,
    "dokumentid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109355_pk_sagstrindokument" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sagstrinsstatus" (
    "id" INTEGER NOT NULL,
    "status" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109359_pk_sagstrinsstatus" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sagstrinstype" (
    "id" INTEGER NOT NULL,
    "type" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109364_pk_sagstrinstypeset" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sagstype" (
    "id" INTEGER NOT NULL,
    "type" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109369_pk_sagstypeset" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sambehandlinger" (
    "id" BIGSERIAL NOT NULL,
    "foerstesagstrinid" INTEGER NOT NULL,
    "andetsagstrinid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109375_pk_sagstrinsagstrin" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "slettet" (
    "id" BIGSERIAL NOT NULL,
    "slettetmapid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,
    "objektid" INTEGER NOT NULL,

    CONSTRAINT "idx_109380_pk_slettet" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "slettetmap" (
    "id" BIGSERIAL NOT NULL,
    "datatype" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109385_pk_slettetmap" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stemme" (
    "id" BIGSERIAL NOT NULL,
    "typeid" INTEGER,
    "afstemningid" INTEGER NOT NULL,
    "aktoerid" INTEGER NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109392_pk_stemmer" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stemmetype" (
    "id" BIGSERIAL NOT NULL,
    "type" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "idx_109397_pk_stemmetype" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "synclogger" (
    "id" BIGSERIAL NOT NULL,
    "entitet" TEXT NOT NULL,
    "internid" INTEGER NOT NULL,
    "eksternid" TEXT NOT NULL,
    "opdateringsdato" TIMESTAMPTZ(6) NOT NULL,
    "antal" INTEGER NOT NULL,
    "godkendtdato" TIMESTAMPTZ(6),

    CONSTRAINT "idx_109404_pk_mqalog" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "idx_109228_ix_fk_emneord_emneordstype" ON "emneord"("typeid");

-- CreateIndex
CREATE UNIQUE INDEX "idx_109260_ix_idmap_originalid_entity" ON "idmap"("originalid", "entity");

-- CreateIndex
CREATE INDEX "idx_109302_ix_fk_deltundersag_sag" ON "sag"("deltundersagid");

-- CreateIndex
CREATE INDEX "idx_109302_ix_fk_fremsatundersag_sag" ON "sag"("fremsatundersagid");

-- CreateIndex
CREATE INDEX "idx_109302_ix_fk_sag_sagskategori" ON "sag"("kategoriid");

-- CreateIndex
CREATE INDEX "idx_109302_ix_fk_sag_sagsstatus" ON "sag"("statusid");

-- CreateIndex
CREATE INDEX "idx_109302_ix_fk_sag_sagstype" ON "sag"("typeid");

-- CreateIndex
CREATE INDEX "idx_109339_ix_fk_sagstrin_sag" ON "sagstrin"("sagid");

-- CreateIndex
CREATE INDEX "idx_109339_ix_fk_sagstrin_sagstrinsstatus" ON "sagstrin"("statusid");

-- CreateIndex
CREATE INDEX "idx_109339_ix_fk_sagstrin_sagstrinstype" ON "sagstrin"("typeid");

-- CreateIndex
CREATE UNIQUE INDEX "idx_109392_AfstemningAktør" ON "stemme"("afstemningid", "aktoerid");


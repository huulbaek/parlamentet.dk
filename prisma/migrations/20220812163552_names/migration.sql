/*
  Warnings:

  - Added the required column `ftid` to the `Question` table without a default value. This is not possible if the table is not empty.
  - Added the required column `samling` to the `Question` table without a default value. This is not possible if the table is not empty.

*/
-- Delete
DELETE FROM "Answers";
DELETE FROM "Question";
DROP INDEX "Question_title_key";
-- AlterTable
ALTER TABLE "Question" ADD COLUMN     "ftid" TEXT NOT NULL,
ADD COLUMN "samling" TEXT NOT NULL;
CREATE UNIQUE INDEX "Question_ftid_samling_key" ON "Question"("ftid", "samling");

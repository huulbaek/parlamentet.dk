-- CreateTable
CREATE TABLE "Quiz" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Quiz_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "QuizResults" (
    "id" SERIAL NOT NULL,
    "initials" TEXT NOT NULL,
    "color" TEXT,
    "logo" TEXT,
    "agreements" INTEGER NOT NULL,
    "disagreements" INTEGER NOT NULL,
    "quizId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "QuizResults_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "QuizResults" ADD CONSTRAINT "QuizResults_quizId_fkey" FOREIGN KEY ("quizId") REFERENCES "Quiz"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

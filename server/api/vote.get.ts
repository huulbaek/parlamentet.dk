import prisma from '../../automatic_prisma_almost/old_prisma/client'

// Fix for faulty bigint serialization
;(BigInt.prototype as any).toJSON = function () {
  return this.toString()
}

type Vote = {
  yay: number
  nay: number
  title: string
  id: number
}

type QuizResult = {
  initials: number
  color: number
  agreements: number
  disagreements: number
  quizId: number
  winCount: number
}

export default defineEventHandler(async () => {
  const result: Array<Vote> =
    await prisma.$queryRaw`SELECT "Question".id, title,
    COUNT("Answers".id) FILTER (WHERE "Answers".vote = 'yay') as yay, 
    COUNT("Answers".id) FILTER (WHERE "Answers".vote = 'nay') as nay
    FROM "Question"
    INNER JOIN "Answers" ON "Answers"."questionId" = "Question".id
    GROUP BY "Question".id, title`

  result.sort((a: Vote, b: Vote) => {
    const aYay = Number(a.yay)
    const aNay = Number(a.nay)
    const bYay = Number(b.yay)
    const bNay = Number(b.nay)
    return aYay / (aYay + aNay) - bYay / (bYay + bNay)
  })

  const pctq: Array<QuizResult> =
    await prisma.$queryRaw`SELECT initials, color, logo, count(initials) as "winCount" FROM
    (SELECT DISTINCT ON ("quizId") initials, color, logo, agreements * 100 / (agreements + disagreements) as "pct"
    FROM "QuizResults"
    WHERE agreements + disagreements > 0
    ORDER BY "quizId", pct DESC) test
    GROUP BY initials, color, logo
    ORDER BY "winCount" DESC`

  const fullCount = await prisma.quiz.count()

  const winners: Array<QuizResult> = pctq.map((winner: QuizResult) => {
    winner.agreements = Number(winner.winCount)
    winner.disagreements = fullCount - Number(winner.winCount)
    return winner
  })

  return { result, winners }
})

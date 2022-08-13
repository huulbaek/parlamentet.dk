import prisma from '../../prisma/client'

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

export default defineEventHandler(async () => {
  const result: Array<Vote> =
    await prisma.$queryRaw`SELECT "Question".id, title,
    COUNT("Answers".id) FILTER (WHERE "Answers".vote = 'yay') as yay, 
    COUNT("Answers".id) FILTER (WHERE "Answers".vote = 'nay') as nay
    FROM "Question"
    INNER JOIN "Answers" ON "Answers"."questionId" = "Question".id
    GROUP BY "Question".id, title`

  result.sort(
    (a: Vote, b: Vote) => Number(a.yay - a.nay) - Number(b.yay - b.nay)
  )

  return result
})

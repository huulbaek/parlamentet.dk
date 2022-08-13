import prisma from '../../prisma/client'

// Fix for faulty bigint serialization
;(BigInt.prototype as any).toJSON = function () {
  return this.toString()
}

export default defineEventHandler(async () => {
  const result: Array<Object> =
    await prisma.$queryRaw`SELECT "Question".id, title,
    COUNT("Answers".id) FILTER (WHERE "Answers".vote = 'yay') as yay, 
    COUNT("Answers".id) FILTER (WHERE "Answers".vote = 'nay') as nay
    FROM "Question"
    INNER JOIN "Answers" ON "Answers"."questionId" = "Question".id
    GROUP BY "Question".id, title
    ORDER BY nay DESC`

  return result
})

import { PrismaClient } from '@prisma/client'
// Fix for faulty bigint serialization
;(BigInt.prototype as any).toJSON = function () {
  return this.toString()
}

export default defineEventHandler(async () => {
  const prisma = new PrismaClient()

  const result: Array<Object> =
    await prisma.$queryRaw`SELECT "Question".id, title,
    COUNT("Answers".id) FILTER (WHERE "Answers".vote = 'yay') as Yay, 
    COUNT("Answers".id) FILTER (WHERE "Answers".vote = 'nay') as Nay
    FROM "Question"
    INNER JOIN "Answers" ON "Answers"."questionId" = "Question".id
    GROUP BY "Question".id, title`

  return result
})

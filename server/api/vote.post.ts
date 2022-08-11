import { PrismaClient } from '@prisma/client'

export default defineEventHandler(async (event) => {
  const body = await useBody(event)
  const prisma = new PrismaClient()

  const question = await prisma.question.upsert({
    where: {
      title: body.title,
    },
    update: {
      title: body.title,
    },
    create: {
      title: body.title,
    },
  })

  const answer = await prisma.answers.create({
    data: {
      questionId: question.id,
      vote: body.vote,
    },
  })

  return {
    result: answer,
  }
})

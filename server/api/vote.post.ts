import prisma from '../../prisma/client'

export default defineEventHandler(async (event) => {
  const body = await useBody(event)

  const question = await prisma.question.upsert({
    where: {
      ftid_samling: {
        ftid: body.ftid,
        samling: body.samling,
      },
    },
    update: {
      title: body.title,
    },
    create: {
      ftid: body.ftid,
      samling: body.samling,
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

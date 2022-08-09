import { PrismaClient } from '@prisma/client'

type QuizResults = {
  initials: string
  agreements: number
  disagreements: number
  logo?: string
  color?: string
  quizId: number
}

export default defineEventHandler(async (event) => {
  const body = await useBody(event)
  const prisma = new PrismaClient()

  const quiz = await prisma.quiz.create({
    data: {},
  })

  body.forEach(async (item: QuizResults) => {
    item.quizId = quiz.id
    const what = await prisma.quizResults.create({
      data: item,
    })
    console.log(what)
  })

  return {
    result: 'success',
  }
})

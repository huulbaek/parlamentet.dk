import { PrismaClient } from '@prisma/client'

type QuizResults = {
  initials: string
  agreements: number
  disagreements: number
  logo: string | null
  color: string | null
  quizId: number
}

export default defineEventHandler(async (event) => {
  const body = await useBody(event)
  const prisma = new PrismaClient()

  const quiz = await prisma.quiz.create({
    data: {},
  })

  const results = [] as QuizResults[]

  /*
  body.forEach(async (item: QuizResults) => {
    item.quizId = quiz.id
    const what = await prisma.quizResults.create({
      data: item,
    })
    results.push(what)
  })
  */

  const test = await prisma.quizResults.createMany({
    data: body.map((item: QuizResults) => {
      return {
        ...item,
        quizId: quiz.id,
      }
    }),
  })

  return {
    result: quiz,
    results,
    test,
  }
})

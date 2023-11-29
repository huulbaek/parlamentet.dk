import prisma from '../../automatic_prisma_almost/old_prisma/client'

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

  const quiz = await prisma.quiz.create({
    data: {},
  })
  const r = await prisma.quizResults.createMany({
    data: body.map((item: QuizResults) => {
      return {
        ...item,
        quizId: quiz.id,
      }
    }),
  })

  return {
    result: r,
  }
})

import { PrismaClient } from '@prisma/client'

export default defineEventHandler(async () => {
  const prisma = new PrismaClient()

  const r = await prisma.quizResults.groupBy({
    by: ['initials', 'logo', 'color'],
    _sum: {
      agreements: true,
      disagreements: true,
    },
  })

  const parties = r.map((item) => {
    return {
      initials: item.initials,
      color: item.color,
      logo: item.logo,
      agreements: item._sum.agreements,
      disagreements: item._sum.disagreements,
    }
  })

  return parties
})

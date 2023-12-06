import { defineEventHandler } from 'h3'
import prisma from '../../../prisma/client'

export default defineEventHandler(async (event) => {
  try {
    const sagList = await prisma.sag.findMany({
      select: {
        id: true,
        titelkort: true,
        titel: true,
        opdateringsdato: true,
      },
      // where: { typeid: 2 },
      orderBy: { opdateringsdato: 'desc' },
      take: 10,
    })

    return sagList || []
  } catch (error) {
    // Handle the error appropriately
    if (error instanceof Error) {
      logger.error(error)
      return { error: error.message }
    } else {
      logger.error('An unknown error occurred')
      return { error: 'An unknown error occurred' }
    }
  }
})

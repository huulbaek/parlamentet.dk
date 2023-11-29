// server/api/fetchSag.ts
import { defineEventHandler } from 'h3'
import logger from '../../../utils/logger'
import prisma from '../../../automatic_prisma_almost/old_prisma/client'
import { query } from 'winston'

export default defineEventHandler(async (event) => {
 const query = getQuery(event)
  // if (!periodeid) {
  //   throw createError(
  //     {
  //       statusCode: 400,
  //       statusMessage: 'Periodeid is not defined'
  //     }
  //   )
  // }
  // Create a where object with the properties that are always present
  const where = {
    typeid: 3,
  }

  // Conditionally add periodeid to the where object
  if (query.periodeid) {
    where.periodeid = query.periodeid
  }

  try {
    const sagList = await prisma.sag.findMany({
      select: {
        id: true,
        titelkort: true,
        titel: true,
        nummer: true,
        opdateringsdato: true,
        resume: true,
        afstemningskonklusion: true,
      },
      where,
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

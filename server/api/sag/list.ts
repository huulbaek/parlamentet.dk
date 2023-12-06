import { defineEventHandler } from 'h3'
import logger from '../../../utils/logger'
import prisma from '../../../prisma/client'

export default defineEventHandler(async (event) => {
  const query = getQuery(event)
  const periodeid = parseInt(query.periodeid, 10) || null
  const page = parseInt(query.page) || 1
  const pageSize = parseInt(query.pageSize) || 10

  const where = {
    typeid: 3,
  }

  if (query.periodeid) {
    where.periodeid = periodeid
  }

  try {
    const skip = (page - 1) * pageSize
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
      take: pageSize,
      skip,
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
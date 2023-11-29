import { loadLastUpdateTimestamp, saveLastUpdateTimestamp } from '../oda/utils'

import { updateSag } from '~/server/oda/fetchAndStoreSag'
import { updatePeriode } from '~/server/oda/periode'

export default defineEventHandler(async (event) => {
  // await updatePeriode()
  // await updateSag()

  return { success: true }
})

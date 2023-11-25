import prisma from '../../prisma/client.js'
import { createContext, periodeGet } from '../../utils/oda.js'

const ctx = createContext()

export async function updatePeriode() {
  let skip = 0
  const top = 100 // Initial batch size
  let periodeData

  // Define a type guard to ensure object conforms to PeriodeCreateManyInput
  type PeriodeCreateManyInput = Partial<FtDomainModelsPeriode> & {
    typeid: number
  }

  function isPeriodeCreateManyInput(
    periode: Partial<FtDomainModelsPeriode>
  ): periode is PeriodeCreateManyInput {
    return periode.type !== undefined
  }

  do {
    periodeData = await periodeGet(ctx, {
      $top: top,
      $skip: skip,
    })
    if (periodeData.value !== undefined) {
      const periodeCreateData = periodeData.value
        .filter((periode) => typeof periode.id === 'number')
        .map(
          (periode): Partial<FtDomainModelsPeriode> => ({
            id: periode.id,
            type: periode.type,
            kode: periode.kode,
            titel: periode.titel,
            startdato: periode.startdato,
            slutdato: periode.slutdato,
            opdateringsdato: periode.opdateringsdato,
          })
        )
        .filter(isPeriodeCreateManyInput)

      await prisma.periode.createMany({
        data: periodeCreateData,
        skipDuplicates: true,
      })
      skip += top
    }
  } while (periodeData.value !== undefined && periodeData.value.length === top)
}

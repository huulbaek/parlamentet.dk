import prisma from '../../prisma/client.js'
import {
  createContext,
  sagGet,
  sagDokumentGet,
  FtDomainModelsSagCreate,
} from '../../utils/oda.js'

const ctx = createContext()

// Get sager for 22/23 samling
export async function updateSag() {
  let skip = 0
  let top = 5 // Initial batch size
  let sagData

  // // Define a type guard to ensure object conforms to SagCreateManyInput
  // type SagCreateManyInput = Partial<FtDomainModelsSag> & { typeid: number }

  // function isSagCreateManyInput(
  //   sag: Partial<FtDomainModelsSag>
  // ): sag is SagCreateManyInput {
  //   return sag.typeid !== undefined
  // }

  do {
    sagData = await sagGet(ctx, {
      $filter: 'periodeid eq 158',
      $top: top,
      $skip: skip,
    })
    if (sagData.value !== undefined) {
      for (const sag of sagData.value) {
        if (typeof sag.id === 'number' && typeof sag.typeid === 'number') {
          await prisma.sag.create({
            data: {
              id: sag.id,
              typeid: sag.typeid,
              kategoriid: sag.kategoriid,
              statusid: sag.statusid,
              titel: sag.titel,
              titelkort: sag.titelkort,
              offentlighedskode: sag.offentlighedskode,
              nummer: sag.nummer,
              nummerprefix: sag.nummerprefix,
              nummernumerisk: sag.nummernumerisk,
              nummerpostfix: sag.nummerpostfix,
              resume: sag.resume,
              afstemningskonklusion: sag.afstemningskonklusion,
              periodeid: sag.periodeid,
              opdateringsdato: sag.opdateringsdato,
              statsbudgetsag: sag.statsbudgetsag,
              baggrundsmateriale: sag.baggrundsmateriale,
              begrundelse: sag.begrundelse,
              paragrafnummer: sag.paragrafnummer,
              paragraf: sag.paragraf,
              lovnummer: sag.lovnummer,
              lovnummerdato: sag.lovnummerdato,
              retsinformationsurl: sag.retsinformationsurl,
              fremsatundersagid: sag.fremsatundersagid,
              deltundersagid: sag.deltundersagid,
            },
          })
        }
      }
    }
    skip += sagData.value.length
    top = sagData.value.length
  } while (sagData.value && sagData.value.length > 0)
}

// async function updateSagDokument(sagId: number) {
//   // Fetch SagDokument data from the ODA API
//   const sagDokumentData = await sagDokumentGet(ctx, {
//     $filter: 'sagid eq ' + sagId,
//   })
//   // Map the fetched SagDokument data to match the Prisma schema
//   const sagDokumentCreateData = sagDokumentData.value
//     .filter(
//       (sagDokument) =>
//         typeof sagDokument.id === 'number' &&
//         typeof sagDokument.sagid === 'number'
//     )
//     .map(
//       (sagDokument): Partial<FtDomainModelsSagDokument> => ({
//         id: sagDokument.id,
//         sagid: sagDokument.sagid,
//         dokumentid: sagDokument.dokumentid,
//         rolleid: sagDokument.rolleid,
//         opdateringsdato: sagDokument.opdateringsdato,
//         // Add other fields as needed...
//       })
//     )
//   // Store the mapped SagDokument data in the database
//   await prisma.sagDokument.createMany({
//     data: sagDokumentCreateData,
//     skipDuplicates: true,
//   })
// }

// const sagCreateData = sagData.value
//   .filter(
//     (sag) => typeof sag.id === 'number' && typeof sag.typeid === 'number'
//   )
//   .map(
//     (sag): Partial<FtDomainModelsSag> => ({
//       id: sag.id,
//       typeid: sag.typeid,
//       kategoriid: sag.kategoriid,
//       statusid: sag.statusid,
//       titel: sag.titel,
//       titelkort: sag.titelkort,
//       offentlighedskode: sag.offentlighedskode,
//       nummer: sag.nummer,
//       nummerprefix: sag.nummerprefix,
//       nummernumerisk: sag.nummernumerisk,
//       nummerpostfix: sag.nummerpostfix,
//       resume: sag.resume,
//       afstemningskonklusion: sag.afstemningskonklusion,
//       periodeid: sag.periodeid,
//       opdateringsdato: sag.opdateringsdato,
//       statsbudgetsag: sag.statsbudgetsag,
//       baggrundsmateriale: sag.baggrundsmateriale,
//       begrundelse: sag.begrundelse,
//       paragrafnummer: sag.paragrafnummer,
//       paragraf: sag.paragraf,
//       lovnummer: sag.lovnummer,
//       lovnummerdato: sag.lovnummerdato,
//       retsinformationsurl: sag.retsinformationsurl,
//       fremsatundersagid: sag.fremsatundersagid,
//       deltundersagid: sag.deltundersagid,
//     })
//   )
//   .filter((sag): sag is FtDomainModelsSag => sag !== null)
//   .filter((sag): sag is FtDomainModelsSag => sag.typeid !== undefined) // Ensure typeid is not undefined
//   .filter(isSagCreateManyInput)

// // Call updateSagDokument for each Sag
// for (const sag of sagCreateData) {
//   await updateSagDokument(sag.id)
//

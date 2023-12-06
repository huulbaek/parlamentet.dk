// server/api/fetchSag.ts
import { defineEventHandler } from 'h3'
import logger from '../../../utils/logger'
import prisma from '../../../prisma/client'

export default defineEventHandler(async (event) => {
    const id = parseInt(event.context.params.id, 10)


    if (isNaN(id)) {
        throw createError({
            statusCode: 400,
            statusMessage: 'ID should be an integer',
        })
    }

    try {
        // const sag = await prisma.sag.findFirst({
        //     where: {id},
        //     include: {
        //         Sagstrin: true,
        //         SagDokument: true,
        //     },
        // },)

        // const sagstrin = await prisma.sagstrin.findMany({
        //     where: {sagid: id},
        // })

        // const behandlendeMinistser = await prisma.aktoer.findMany({
        //     where: { typeid: 2 },
        //     select: {
        //         AktoerRolle: true,
        //         Aktoer: true,
        //     },
        // // })

        // const behandlendeFTmedlemmer = await prisma.aktoer.findMany({
        //     where: { typeid: 3 },
        //     select: {
        //         AktoerRolle: true,
        //         Aktoer: true,
        //     },
        // })

        // const sagAktoer = await prisma.sagAktoer.findMany({
        //     where: {sagid: id},
        // //         select: {
        // //             SagAktoerRolle: true,
        // //             Aktoer: true,
        // //         },
        //     include: {
        //         SagAktoerRolle: true,
        //         Aktoer: {
        //         },
        //     },
        // })


        const sag = await prisma.sag.findUnique({
            where: { id },
            include: {
                Sagstrin: {
                    include: {
                        Dagsordenspunkt: true,
                        SagstrinAktoer: {
                            include: {
                                Aktoer: true,
                                SagstrinAktoerRolle: true,
                            },
                        },
                        // SagstrinDokument: {
                        //     include: {
                        //         Dokument: {
                        //             include: {
                        //                 Fil: true,
                        //             }
                        //         },
                        //     },
                        // },
                    },
                },
                SagDokument: {
                    include: {
                        Dokument: {
                            include: {
                                Fil: true
                            }
                        },
                        SagDokumentRolle: true,
                    },
                },
                SagAktoer: {
                    include: {
                        Aktoer: {
                            include: {
                                Aktoertype: true,
                                Periode: true,
                                // FraAktoerAktoer: {
                                //     include: {
                                //         TilAktoer: true,
                                //         AktoerAktoerRolle: true,
                                //     },
                                // },
                                // TilAktoerAktoer: {
                                //     include: {
                                //         FraAktoer: true,
                                //         AktoerAktoerRolle: true,
                                //     },
                                // },
                                // DokumentAktoer: {
                                //     include: {
                                //         Dokument: true,
                                //         DokumentAktoerRolle: true,
                                //     },
                                // },
                                // MoedeAktoer: {
                                //     include: {
                                //         Moede: true,
                                //     },
                                // },
                                // Stemme: {
                                //     include: {
                                //         Afstemning: true,
                                //     },
                                // },
                            },
                        },
                        SagAktoerRolle: true,
                    },
                },
            },
        });



        return  sag  || null
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

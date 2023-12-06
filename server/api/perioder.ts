import { defineEventHandler } from 'h3'
import prisma from '../../prisma/client';


export default defineEventHandler(async (event) => {

    const perioder = await prisma.periode.findMany({
    select: {
        id: true,
        titel: true,
        slutdato: true,
    },
    where: {
        type: "samling",
        slutdato: {
            gte: new Date('2013-01-01T00:00:00Z'),
            lte: new Date(),
        },
    },
    orderBy: { slutdato: 'desc' },
    });
    return perioder || []
})
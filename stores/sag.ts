// stores/sag.ts
import { defineStore } from 'pinia'

interface Sag {
    id: number;
    titel: string | null;
    titelkort: string | null;
    typeid: number;
    kategoriid: number | null;
    offentlighedskode: string | null;
    nummer: string | null;
    nummerprefix: string | null;
    nummernumerisk: string | null;
    nummerpostfix: string | null;
    resume: string | null;
    afstemningskonklusion: string | null;
  }

export const useSagStore = defineStore('sag', {
  state: () => ({
    sag: null as Sag | null, // Initialize sag as null
  }),
  actions: {
    setSag(sag: Sag) {
      this.sag = sag
    },
  },
})
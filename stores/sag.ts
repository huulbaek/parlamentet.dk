// stores/sag.ts
import { defineStore } from 'pinia'
import { fetchAndStoreSag } from '../server/oda/fetchAndStoreSag'

// interface Sag {
//     id: number;
//     titel: string | null;
//     titelkort: string | null;
//     typeid: number;
//     kategoriid: number | null;
//     offentlighedskode: string | null;
//     nummer: string | null;
//     nummerprefix: string | null;
//     nummernumerisk: string | null;
//     nummerpostfix: string | null;
//     resume: string | null;
//     afstemningskonklusion: string | null;
//   }

export const useSagStore = defineStore('sag', {
  state: () => ({
    sag: {},
    // other state properties...
  }),
  actions: {
    async fetchSag() {
      await fetchAndStoreSag()
    },
    // other actions...
  },
  // getters...
})

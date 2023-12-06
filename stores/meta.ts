// stores/meta.ts
import { defineStore } from 'pinia'

interface Periode {
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
export const useSagStore = defineStore('meta', {
  state: () => ({
    perioder: [] as Periode[],
    selectedPeriode: null as Periode | null,
  }),
  getters: {
    getPerioder(state) {
      return state.perioder
    },
  },
  actions: {
    setSelectedPeriode(periode: Periode) {
      this.selectedPeriode = periode
    },
  },
})
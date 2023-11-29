import { ColumnDef } from '@tanstack/vue-table'

export interface Lovforslag {
  id: number
  titel: string
  titelkort: string
  opdateringsdato: string
}
export const columns: Lovforslag[] = [
  {
    key: 'id',
    label: 'ID',
  },
  {
    key: 'titel',
    label: 'Titel',
  },
  {
    key: 'titelkort',
    label: 'Titelkort',
  },
  {
    key: 'opdateringsdato',
    label: 'Opdateringsdato',
  },
]

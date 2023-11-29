<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useFetch } from '@vueuse/core'

import { useMainStore } from '@/stores/main'

const mainStore = useMainStore()

type Lovforslag = {
  id: number
  titelkort: string
  nummer: string
  resume: string
  opdateringsdato: string
}

const columns = [
  {
    key: 'id',
    label: 'Id',
  },
  {
    key: 'nummer',
    label: 'Nummer',
  },
  {
    key: 'titelkort',
    label: 'Titelkort',
  },
  {
    key: 'resume',
    label: 'Resume',
  },
  {
    key: 'opdateringsdato',
    label: 'Opdateringsdato',
  },
]
// onst data  = await 

const lovforslag = ref<Lovforslag[]>([])
async function getData(): Promise<Lovforslag[]> {
  // Fetch data from your API here.
  const { data } = await useFetch('/api/sag/lovforslag/',{ query: {periodeid: 158} }).get().json()
  return data.value
}
// const data = await useFetch('/api/sag/all').get().json()

onMounted(async () => {
  mainStore.updateHeaderTitle('Lovforslag')
  lovforslag.value = await getData()
})

</script>

<template>
  <div class="container mx-auto py-10">
    <div v-for="item in lovforslag" :key="item.id" class="card">
      <h2>{{ item.titelkort }}</h2>
      <p>{{ item.nummer }}</p>
      <p>{{ item.resume }}</p>
      <p>{{ item.opdateringsdato }}</p>
      <nuxt-link :to="`/lovforslag/${item.id}`">View Details</nuxt-link>
    </div>
  </div>
</template>

<style scoped>
.card {
  border: 1px solid #ccc;
  border-radius: 4px;
  padding: 20px;
  margin-bottom: 20px;
}
</style>
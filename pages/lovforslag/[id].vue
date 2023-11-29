<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useFetch } from '@vueuse/core'
import { useRoute } from 'vue-router'

import { useMainStore } from '@/stores/main'
import { useSagStore } from '@/stores/sag'

const mainStore = useMainStore()
const sagStore = useSagStore()

type Lovforslag = {
  id: number
  titelkort: string
  nummer: string
  resume: string
  opdateringsdato: string
  afstemningskonklusion: string
}
const route = useRoute()

const lovforslag = ref<Lovforslag>()
async function getData(): Promise<Lovforslag> {
  // Fetch data from your API here.
  // const { data } = await useFetch('/api/sag',{ query: {id: Number(route.params.id)} }).get().json()
  const { data } = await useFetch(`/api/sag/${route.params.id}`).get().json()
  return data.value
}
// const data = await useFetch('/api/sag/all').get().json()

onMounted(async () => {
  const id = Number(route.params.id)
  const { data } = await useFetch(`/api/sag/${id}`).get().json()
  console.log(data.value)
  sagStore.setSag(data.value)
  mainStore.updateHeaderTitle(sagStore.sag?.nummer ?? 'Lovforslag')
})

</script>

<template>
  <div class="container mx-auto py-10">
    <h1>{{ sagStore.sag?.titelkort }}</h1>
    <p>{{ sagStore.sag?.resume }}</p>
    <h3>{{ sagStore.sag?.afstemningskonklusion }}</h3>
    <pre>{{ JSON.stringify(sagStore.sag, null, 2) }}</pre>

  </div>
</template>

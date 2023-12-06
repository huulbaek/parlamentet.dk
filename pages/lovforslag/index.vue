<script setup lang="ts">
import { ref, onMounted, reactive } from 'vue'

import { useMainStore } from '@/stores/main'

// const mainStore = useMainStore()

// type Lovforslag = {
//   id: number
//   titelkort: string
//   nummer: string
//   resume: string
//   opdateringsdato: string
// }



// const fetchPerioder = async () => {
//   const response = await $fetch('/api/perioder/')
//   return response.map((periode: any) => ({ id: periode.id, titel: periode.titel }))
// }

// const {data : perioder} = useAsyncData('perioder', fetchPerioder)

// const selectedPeriode = ref(null)

// // Pagination state
// const pagination = reactive({
//   currentPage: 1,
//   pageSize: 10,
// })

// // Fetch data with pagination
// const fetchLovforslag = async () => {
//   return $fetch('/api/sag/list', {
//     params: {
//       periodeid: selectedPeriode.value, 
//       page: pagination.currentPage,
//       pageSize: pagination.pageSize,
//     },
//   })
// }

// const { data: lovforslag, pending, refresh } = useAsyncData('lovforslag', fetchLovforslag)

// onMounted(async () => {
//   mainStore.updateHeaderTitle('Lovforslag')
//   // Set the default selected period to 158 once the perioder data is loaded
//   perioder.then((loadedPerioder) => {
//   const defaultPeriode = loadedPerioder.find(p => p.id === 158)
//   selectedPeriode.value = defaultPeriode || null
//   refresh() // Initial fetch with the default period

// })

// })

// // Function to change page
// const changePage = (newPage) => {
//   pagination.currentPage = newPage
//   refresh()
// }

const mainStore = useMainStore()

type Lovforslag = {
  id: number
  titelkort: string
  nummer: string
  resume: string
  opdateringsdato: string
}

const fetchPerioder = async () => {
  const response = await $fetch('/api/perioder/')
  return response.map((periode: any) => ({ id: periode.id, titel: periode.titel }))
}

const { data: perioder } = useAsyncData('perioder', fetchPerioder)

const selectedPeriode = ref<number | null>(null)

// Computed property for the current period
const currentPeriode = computed(() => perioder.value?.find((periode) => periode.id === selectedPeriode.value))

// Pagination state
const pagination = reactive({
  currentPage: 1,
  pageSize: 10,
})

// Fetch data with pagination
const fetchLovforslag = async () => {
  return $fetch('/api/sag/list', {
    params: {
      periodeid: selectedPeriode.value,
      page: pagination.currentPage,
      pageSize: pagination.pageSize,
    },
  })
}

const { data: lovforslag, refresh } = useAsyncData('lovforslag', fetchLovforslag)

onMounted(async () => {
  mainStore.updateHeaderTitle('Lovforslag')
  // Set the default selected period to 158 once the perioder data is loaded
  selectedPeriode.value = 158
  refresh() // Initial fetch with the default period
})

// Watch for changes in selectedPeriode and refresh the data
watch(selectedPeriode, () => {
  refresh()
})

// Function to change page
const changePage = (newPage: number) => {
  pagination.currentPage = newPage
  refresh()
}
</script>

<template>

  <div class="container mx-auto py-10">
    <USelectMenu
      v-model="selectedPeriode"
      :options="perioder"
      class="w-full lg:w-96"
      placeholder="Vælg en periode"
      searchable
      searchable-placeholder="Search by period title"
      option-attribute="titel"
      value-attribute="id"
      :search-attributes="['titel']"
    >
      <template #label>
        {{ currentPeriode?.titel }}
      </template>
      <template #option="{ option: periode }">
        <span class="truncate">{{ periode.titel }}</span>
      </template>
    </USelectMenu>
    <div v-for="item in lovforslag" :key="item.id" class="card">
      <h2>{{ item.titelkort }}</h2>
      <p>{{ item.nummer }}</p>
      <p>{{ item.resume }}</p>
      <p>{{ item.opdateringsdato }}</p>
      <nuxt-link :to="`/lovforslag/${item.id}`">View Details</nuxt-link>
    </div>
    <!-- Pagination Controls -->
    <div class="pagination">
      <button @click="changePage(pagination.currentPage - 1)" :disabled="pagination.currentPage === 1">Previous</button>
      <button @click="changePage(pagination.currentPage + 1)">Next</button>
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
.pagination {
  display: flex;
  justify-content: space-between;
  margin-top: 20px;
}
</style>
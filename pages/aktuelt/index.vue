<template>
  <div class="flex">
    <div class="ml-4">
      <h1>Oh yes!</h1>
      <p>Vi skal til at opdatere ODA. Tryk på knappen her for at hente:</p>
      <button
        class="rounded bg-blue-500 px-4 py-2 font-bold text-white hover:bg-blue-700"
        @click="fetchData"
      >
        Fetch Data
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useFetch } from '@vueuse/core'

import { useMainStore } from '@/stores/main'

const mainStore = useMainStore()

useHead({
  title: 'Parlamentet.dk – ODA Test',
})

onMounted(async () => {
  mainStore.updateHeaderTitle('ODA Test')
})

const fetchData = async () => {
  const { data, error } = await useFetch('/api/oda').post().json()
  // Use the useFetch composable from VueUse to call the server route

  if (error.value) {
    console.error('Failed to fetch and store sag:', error.value)
  } else {
    console.log('Success:', data.value)
  }
}
</script>

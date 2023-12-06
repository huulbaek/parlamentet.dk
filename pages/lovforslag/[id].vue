<script setup lang="ts">
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

const getStatusText = (statusId: number) => {
  // Replace with actual status text mapping if available
  const statusMap = {
    28: 'Aktiv',
    // ... other status mappings
  };
  return statusMap[statusId] || 'Ukendt';
};
// Fetch the main sag data
const { data: sagContent, pending: sagPending, error: sagError } = useAsyncData(async () => {
  const id = route.params.id;
  return await $fetch(`/api/sag/`, {
    params: {
      id: id,
    },
  });
});

// Fetch the related documents in a separate call
const { data: documentsContent, pending: documentsPending, error: documentsError } = useAsyncData(async () => {
  const id = route.params.id;
  return await $fetch(`/api/sag/documents`, {
    params: {
      id: id,
    },
  });
});

// Combine pending states and errors for the template if needed
const pending = computed(() => sagPending.value || documentsPending.value);
const error = computed(() => sagError.value || documentsError.value);


// const data = await useFetch('/api/sag/all').get().json()

// onMounted(async () => {
//   const id = Number(route.params.id)
//   const { data } = await useFetch(`/api/sag/${id}`).get().json()
//   console.log(data.value)
//   sagStore.setSag(data.value)
// })

</script>

<template>
  <div class="container mx-auto py-10">
    <div v-if="pending">
      Loading ...
    </div>
    <div v-else>
      <div v-if="error">
        <p>Error loading data: {{ error.message }}</p>
      </div>
      <div v-else>
        <h1 class="text-2xl font-bold mb-4">{{ sagContent.titel }}</h1>
        <p class="mb-2"><strong>Kort titel:</strong> {{ sagContent.titelkort }}</p>
        <p class="mb-2"><strong>Nummer:</strong> {{ sagContent.nummer }}</p>
        <p class="mb-2"><strong>Status:</strong> {{ getStatusText(sagContent.statusid) }}</p>
        <p class="mb-2"><strong>Offentlighedskode:</strong> {{ sagContent.offentlighedskode }}</p>
        <p class="mb-2"><strong>Resume:</strong> {{ sagContent.resume }}</p>
        <p class="mb-2"><strong>Opdateringsdato:</strong> {{ new Date(sagContent.opdateringsdato).toLocaleDateString() }}</p>
        <h2 class="text-xl font-semibold mt-6 mb-4">Sagstrin</h2>
        <div v-if="sagContent.Sagstrin && sagContent.Sagstrin.length > 0">
          <ul>
            <li v-for="sagstrin in sagContent.Sagstrin" :key="sagstrin.id" class="mb-2">
              <strong>{{ sagstrin.titel }}</strong> ({{ new Date(sagstrin.dato).toLocaleDateString() }})
            </li>
          </ul>
        </div>
        <div v-else>
          Tidsplan endnu ikke fastlagt
        </div>
        <FilContent :files="documentsContent" />
      </div>
    </div>
  </div>
</template>

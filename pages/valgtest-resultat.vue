<template>
  <div>
    <div class="grid sm:grid-rows-2 md:grid-cols-2">
      <Parties class="order-last md:order-first" :parties="parties" />
      <div class="lg:ml-4">
        <h1>Lidt om data</h1>
        <p>
          Testen er i alt taget <strong>{{ meta.count }}</strong> gange.
        </p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useMainStore } from '@/stores/main'
import type { Party } from '@/stores/electionQuiz'

const mainStore = useMainStore()
const parties = ref([])
const meta = ref({
  count: 0,
})

useHead({
  title:
    'Resultat af Den Historiske Valgtest – Folketingsvalg 2022 – Parlamentet.dk',
  meta: [
    {
      property: 'og:image',
      content: 'https://parlamentet-dk.vercel.app/valgtest.jpg',
    },
    {
      property: 'description',
      content: 'Gennemsnitligt resultat af valgtesten for folketingsvalg 2022',
    },
  ],
})

onMounted(() => {
  mainStore.updateHeaderTitle('Resultat af Den Historiske Valgtest')
  getResults()
})

const getResults = async () => {
  const response = await fetch('/api/election', {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json',
    },
  })
  const json = await response.json()
  json.parties.sort((a: Party, b: Party) => {
    let aaa = a.agreements / (a.disagreements + a.disagreements)
    let bbb = b.agreements / (b.disagreements + b.disagreements)
    if (a.agreements + a.disagreements === 0) {
      aaa = 0
    }
    if (b.agreements + b.disagreements === 0) {
      bbb = 0
    }
    return bbb - aaa
  })
  parties.value = json.parties
  meta.value.count = json.count
}
</script>

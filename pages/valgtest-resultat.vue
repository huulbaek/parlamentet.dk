<template>
  <div>
    <div class="grid sm:grid-rows-2 md:grid-cols-2">
      <Parties class="order-last md:order-first" :parties="parties" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { useMainStore } from '@/stores/main'
import type { Party } from '@/stores/electionQuiz'

const mainStore = useMainStore()
const parties = ref([])

useHead({
  title: 'Resultat – Den Historiske Valgtest – Parlamentet.dk',
  meta: [
    {
      property: 'og:image',
      content: 'https://parlamentet-dk.vercel.app/valgtest.jpg',
    },
    {
      property: 'description',
      content: 'Gennemsnitligt resultat af valgtesten',
    },
  ],
})

onMounted(() => {
  mainStore.updateHeaderTitle('Resultat – Den Historiske Valgtest')
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
  json.sort((a: Party, b: Party) => {
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
  parties.value = json
}
</script>

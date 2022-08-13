<template>
  <div>
    <div class="grid md:grid-cols-2">
      <Parties class="order-last md:order-first" :parties="parties" />
      <div class="lg:ml-4">
        <h1 class="hidden md:block">Lidt om data</h1>
        <p class="mb-5">
          Testen er i alt taget <strong>{{ meta.count }}</strong> gange.
        </p>
      </div>
    </div>
    <div class="mt-10">
      <h1 class="mb-3">Detaljeret</h1>
      <div v-for="vote in votes" :key="vote.title">
        <div class="text-xl">{{ vote.title }}</div>
        <div
          class="progress-bar inline-block h-10 items-center justify-center whitespace-nowrap bg-green-600 font-bold text-white transition-transform"
          :style="{
            width: voteWidth(vote, 'yay'),
          }"
        ></div>
        <div
          class="progress-bar inline-block h-10 items-center justify-center whitespace-nowrap bg-red-600 font-bold text-white transition-transform"
          :style="{
            width: voteWidth(vote, 'nay'),
          }"
        ></div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useMainStore } from '@/stores/main'
import type { Party } from '@/stores/electionQuiz'

type Vote = {
  id: string
  title: string
  yay: string
  nay: string
}

const mainStore = useMainStore()
const parties = ref([])
const meta = ref({
  count: 0,
})
const votes = ref<Vote[]>([])

onMounted(() => {
  mainStore.updateHeaderTitle('Resultat af Den Historiske Valgtest')
  getResults()
  getVotes()
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

const getVotes = async () => {
  const response = await fetch('/api/vote', {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json',
    },
  })
  const json = await response.json()
  votes.value = json
}

const voteWidth = (vote: Vote, type: string): string => {
  let width = 0
  const yays = Number(vote.yay)
  const nays = Number(vote.nay)
  if (type === 'yay') {
    width = (yays / (yays + nays)) * 100
  } else {
    width = (nays / (yays + nays)) * 100
  }
  return `${width}%`
}

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
    {
      property: 'og:description',
      content: 'Gennemsnitligt resultat af valgtesten for folketingsvalg 2022',
    },
  ],
})
</script>

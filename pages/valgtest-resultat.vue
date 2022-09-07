<template>
  <div>
    <div class="grid md:grid-cols-2">
      <Parties class="order-last md:order-first" :parties="parties" />
      <div class="lg:ml-4">
        <h1 class="hidden md:block">Lidt om data</h1>
        <p>
          Tallene <span class="hidden md:inline">til venstre</span>
          <span class="inline md:hidden">herunder</span> illustrerer, hvor mange
          enige svar der har været ud af antallet af spørgsmål.
        </p>
        <p>
          Fx betyder <em>238 / 477</em>, at der 238 klikket <em>ja tak</em> ud
          af <em>477</em> mulige. Den store forskel i antallet af mulige forslag
          skyldes, at der er forskel på antallet af partier, der har stemt på de
          forskellige forslag.
        </p>
        <p>
          Hvis du har mod og snilde, kan du selv få
          <a href="https://github.com/huulbaek/parlamentet.dk"
            >forslag tilføjet her</a
          >.
        </p>
        <p class="mb-5">
          Testen er i alt taget <b>{{ meta.count }}</b> gange.
        </p>
      </div>
    </div>
    <div class="mt-10">
      <h1 class="mb-3">Fordeling på spørgsmål</h1>
      <div v-for="vote in votes" :key="vote.title">
        <div class="text-xl">{{ vote.title }}</div>
        <div class="relative">
          <div
            class="progress-bar inline-block h-10 items-center justify-center whitespace-nowrap bg-green-600 font-bold text-white transition-transform"
            :style="{
              width: voteWidth(vote, 'yay'),
            }"
          />
          <div
            class="progress-bar inline-block h-10 items-center justify-center whitespace-nowrap bg-red-600 font-bold text-white transition-transform"
            :style="{
              width: voteWidth(vote, 'nay'),
            }"
          />
        </div>
      </div>
    </div>
    <div class="mt-10">
      <h1 class="mb-3">Som meningsmåling (vindere)</h1>
      <Parties
        class="order-last md:order-first"
        :parties="winners"
        :normalize="true"
      />
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
const winners = ref([])
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
  votes.value = json.result
  winners.value = json.winners
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
    'Gennemsnit af Den Historiske Valgtest – Folketingsvalg 2022 – Parlamentet.dk',
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

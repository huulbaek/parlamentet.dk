<template>
  <div class="relative">
    <div
      id="quiz-progress"
      class="absolute -right-4 -top-5 h-8 w-20 rounded-lg bg-emerald-700 text-center text-xl font-bold text-white lg:-right-10 lg:-top-10"
    >
      <span
        >{{ electionQuizStore.step + 1 }} /
        {{ electionQuizStore.quiz.length }}</span
      >
    </div>
    <div class="grid md:grid-cols-2">
      <Parties class="order-last md:order-first" />
      <Question
        v-if="electionQuizStore.step < electionQuizStore.quiz.length"
        class="lg:ml-5"
      />
      <div
        v-if="electionQuizStore.step === electionQuizStore.quiz.length"
        class="text-xl lg:ml-5"
      >
        <h1>Færdig!</h1>
        <p>
          Du er nået til enden. Om du kan bruge denne test til noget, er helt op
          til dig selv.
        </p>
        <p>
          Du kan se det samlede
          <NuxtLink to="/valgtest-resultat">resultat her.</NuxtLink>
        </p>
        <div class="h-20 w-20">
          <button v-if="electionQuizStore.step !== 0" @click="previousStep">
            <RewindIcon class="block h-20 w-20 text-yellow-600" />
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { RewindIcon } from '@heroicons/vue/solid/esm/index.js'
import { useElectionQuizStore } from '@/stores/electionQuiz'
import { useMainStore } from '@/stores/main'

const electionQuizStore = useElectionQuizStore()
const mainStore = useMainStore()
const resultIsSaved = ref(false)

const previousStep = () => {
  electionQuizStore.previousStep()
}

onMounted(() => {
  mainStore.updateHeaderTitle('Folketingsvalg 2022 – Den Historiske Valgtest')
})

electionQuizStore.$subscribe((_mutation, state) => {
  if (state.step === state.quiz.length - 1) {
    if (!resultIsSaved.value) {
      resultIsSaved.value = true
      saveResult()
    }
  }
})

const saveResult = async () => {
  // Remove title
  const data = electionQuizStore.quizResult.map((item) => {
    delete item.title
    return item
  })
  await fetch('/api/election', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(data),
  })
}

useHead({
  title: 'Folketingsvalg 2022 – Den Historiske Valgtest – Parlamentet.dk',
  meta: [
    {
      property: 'og:image',
      content: 'https://parlamentet-dk.vercel.app/valgtest.jpg',
    },
    {
      property: 'description',
      content:
        'Du kan på denne side afgive din stemme til udvalgte forslag fra folketinget. Folketingets medlemmer har allerede afgivet deres stemme til forslagene, så når du har afgivet dine stemmer, kan du se, hvor enig du i virkeligheden er med folketingets partier.',
    },
    {
      property: 'og:description',
      content:
        'Du kan på denne side afgive din stemme til udvalgte forslag fra folketinget. Folketingets medlemmer har allerede afgivet deres stemme til forslagene, så når du har afgivet dine stemmer, kan du se, hvor enig du i virkeligheden er med folketingets partier.',
    },
  ],
})
</script>

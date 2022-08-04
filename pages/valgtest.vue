<template>
  <div class="relative">
    <div
      class="absolute -right-10 -top-10 h-8 w-20 rounded-lg bg-emerald-700 text-center text-xl font-bold text-white"
    >
      <span
        >{{ electionQuizStore.step + 1 }} /
        {{ electionQuizStore.quiz.length }}</span
      >
    </div>
    <div class="grid sm:grid-rows-2 md:grid-cols-2">
      <Parties class="order-last md:order-first" />
      <Question class="mb-10" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { useElectionQuizStore } from '@/stores/electionQuiz'
import { useMainStore } from '@/stores/main'

const electionQuizStore = useElectionQuizStore()
const mainStore = useMainStore()

useHead({
  title: 'Den Historiske Valgtest – Parlamentet.dk',
})

onMounted(() => {
  mainStore.updateHeaderTitle('Den Historiske Valgtest')
})
</script>

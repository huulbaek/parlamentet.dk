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
      <Parties class="order-last md:order-first" :party-counts="partyCounts" />
      <Question class="mb-10" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { useElectionQuizStore } from '@/stores/electionQuiz'
import { useMainStore } from '@/stores/main'

interface IObjectKeys {
  [key: string]: any
}

const electionQuizStore = useElectionQuizStore()
const mainStore = useMainStore()
const partyCounts = ref({} as IObjectKeys)

useHead({
  title: 'Den Historiske Valgtest – Parlamentet.dk',
})

onMounted(() => {
  mainStore.updateHeaderTitle('Den Historiske Valgtest')
  // Update participation counts for parties
  const present = electionQuizStore.quiz.flatMap((item) =>
    item.yay.concat(item.nay).concat(item.absent_or_maybe)
  )
  for (const initial of present) {
    partyCounts.value[initial] = partyCounts.value[initial]
      ? partyCounts.value[initial] + 1
      : 1
  }
})
</script>

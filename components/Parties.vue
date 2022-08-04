<template>
  <div>
    <div
      v-for="party in electionQuizStore.quizResult"
      :key="party.initials"
      class="h-10"
    >
      <PartyItem :party="party" :agreements="party.agreements" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { useElectionQuizStore } from '@/stores/electionQuiz'
const electionQuizStore = useElectionQuizStore()
</script>

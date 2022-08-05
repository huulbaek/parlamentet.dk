<template>
  <div>
    <div
      v-for="party in electionQuizStore.quizResult"
      :key="party.initials"
      class="h-10"
    >
      <PartyItem
        :party="party"
        :agreements="party.agreements"
        :present-count="partyCounts[party.initials]"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { useElectionQuizStore } from '@/stores/electionQuiz'
const electionQuizStore = useElectionQuizStore()

defineProps({
  partyCounts: {
    type: Object,
    required: true,
  },
})
</script>

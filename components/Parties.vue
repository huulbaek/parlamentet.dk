<template>
  <div>
    <transition-group v-if="!parties" name="list" tag="ul">
      <li v-for="(party, idx) in electionQuizStore.sortedQuizResult" :key="idx">
        <PartyItem :party="party" />
      </li>
    </transition-group>
    <transition-group v-else name="list" tag="ul">
      <li v-for="(party, idx) in parties" :key="idx">
        <PartyItem :party="party" />
      </li>
    </transition-group>
  </div>
</template>

<script setup lang="ts">
import { useElectionQuizStore } from '@/stores/electionQuiz'
import type { Party } from '@/stores/electionQuiz'
const electionQuizStore = useElectionQuizStore()

defineProps<{
  parties?: Array<Party>
}>()
</script>

<style></style>

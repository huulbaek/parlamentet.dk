<template>
  <div>
    <h1>Velkommen til Parlamentet.dk</h1>
    <p>Her finder du det nye <em>Parlamentet.dk</em>.</p>
    <p>
      Det gamle Parlamentet.dk var en applikation, hvor alle lov- og
      beslutningsforslag fra Folketinget var tilgængelige for alle, så
      kompetente mennesker kunne skrive resumeer af dem og de kunne debatteres
      og til sidst stemmes om.
    </p>
    <p>
      Det var også et system, hvor man kunne fremsætte egne forslag, som så blev
      sendt videre til Folketingets medlemmer, hvis de blev vedtaget.
    </p>
    <p>
      Det led af forfald og den
      <a href="https://en.wikipedia.org/wiki/Technical_debt">tekniske gæld</a>
      blev for stor. I dag er det et open source projekt, hvor tanken er at tage
      det bedste med videre – til at starte med er det den historiske valgtest.
    </p>
    <p>
      Hvis du vil arbejde på projektet, så kan du finde det her:
      <a href="https://github.com/huulbaek/parlamentet.dk">GitHub</a>
    </p>
  </div>
</template>

<script setup lang="ts">
import { useMainStore } from '@/stores/main'

const mainStore = useMainStore()

useHead({
  title: 'Parlamentet.dk – deltagende demokrati',
})

onMounted(() => {
  mainStore.updateHeaderTitle('Parlamentet.dk – deltagende demokrati')
})
</script>

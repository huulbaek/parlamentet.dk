<template>
  <div>
    <h1>Velkommen til Parlamentet.dk</h1>
    <p>
      Her finder du det nye <em>Parlamentet.dk</em>, som er noget, som vi ikke
      helt ved, hvad skal være endnu.
    </p>
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
      Det led af forfald og den tekniske gæld blev for stor. I dag er det et
      open source projekt, hvor tanken er at tage det bedste med videre – til at
      starte med er det den historiske valgquiz.
    </p>
    <p>
      Hvis du vil arbejde på projektet, så kan du finde det her:
      <a
        class="text-blue-500 hover:text-blue-700"
        href="https://github.com/huulbaek/parlamentet.dk"
        >GitHub</a
      >
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

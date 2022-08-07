<template>
  <div class="flex">
    <img src="/404.png" />
    <div class="ml-4">
      <h1>Oh ohno!</h1>
      <p>
        Vi kunne ikke finde siden. Det er allermest sandsynligt, at siden er en
        del af det "gamle" parlamentet.dk.
      </p>
      <p>
        Det kan være, at den kommer igen engang; tjek planerne på
        <a
          class="text-blue-500 hover:text-blue-700"
          href="https://github.com/huulbaek/parlamentet.dk"
          >GitHub</a
        >
      </p>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useMainStore } from '@/stores/main'

const mainStore = useMainStore()

useHead({
  title: 'Parlamentet.dk – side ikke fundet',
})

onMounted(() => {
  mainStore.updateHeaderTitle('404 – side ikke fundet')
})
</script>

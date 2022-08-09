<template>
  <div class="min-h-full">
    <Header />
    <main class="-mt-32">
      <div class="mx-auto max-w-7xl px-4 pb-12 sm:px-6 lg:px-8">
        <div
          class="rounded-lg px-5 py-6 shadow-lg sm:px-6"
          style="background-image: url('/gradient.jpg'); background-size: cover"
        >
          <div class="h-full">
            <NuxtPage />
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
useHead({
  bodyAttrs: {
    class: 'h-full',
  },
  htmlAttrs: {
    class: 'h-full bg-gradient-to-r from-gray-100 to-gray-300',
  },
})
</script>

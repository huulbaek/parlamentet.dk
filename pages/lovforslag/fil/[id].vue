<script setup lang="ts">
import { ref } from 'vue';
import { useRoute } from 'vue-router';
import { useAsyncData } from 'nuxt/app';
import { useSagStore } from '@/stores/sag';

const route = useRoute();
const sagStore = useSagStore();

const { data: content, pending, error} = useAsyncData(async () => {
  const id = route.params.id;
  const response = await $fetch(`/api/sag/files/${id}`);
  return response;
});

if (error.value) {
  // console.error('Failed to fetch content', error.value);
}
</script>

<template>
  <div class="container mx-auto py-10">
    <div v-if="pending">
      Loading ...
    </div>
    <div v-else>
      <FilContent :files="content" />
    </div>
  </div>
</template>
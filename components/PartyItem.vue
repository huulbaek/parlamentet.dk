<template>
  <div class="my-2 flex">
    <img
      :src="party.logo"
      class="h-10"
      :alt="`Partilogo for ${party.initials}`"
    />
    <div class="ml-3 w-full">
      <div
        class="progress-bar flex h-full items-center justify-center whitespace-nowrap font-bold text-white transition-transform"
        style="min-width: 80px"
        :style="{
          width: `${computedPct !== 0 ? computedPct : 20}%`,
          backgroundColor: party.color,
        }"
      >
        <span
          >{{ party.agreements }} /
          {{ party.agreements + party.disagreements }} ({{
            computedPct
          }}%)</span
        >
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
const props = defineProps({
  party: {
    type: Object,
    required: true,
  },
  agreements: {
    type: Number,
    required: true,
  },
})

const computedPct = computed(() => {
  if (props.party.agreements + props.party.disagreements === 0) {
    return 0
  }
  return parseInt(
    (
      (props.agreements /
        (props.party.agreements + props.party.disagreements)) *
      100
    ).toFixed(0)
  )
})
</script>

<style scoped>
.progress-bar {
  transition-property: all;
  transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
  transition-duration: 1s;
}
</style>

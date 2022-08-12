<template>
  <div class="my-2 flex h-10">
    <img
      :src="party.logo"
      class="h-10"
      :alt="`Partilogo for ${party.initials}`"
    />
    <div class="ml-3 w-full">
      <div
        class="progress-bar flex h-full items-center justify-center whitespace-nowrap rounded-r-full font-bold text-white transition-transform"
        style="min-width: 7rem"
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
})

const computedPct = computed(() => {
  if (props.party.agreements + props.party.disagreements === 0) {
    return 0
  }
  return parseInt(
    (
      (props.party.agreements /
        (props.party.agreements + props.party.disagreements)) *
      100
    ).toFixed(0)
  )
})
</script>

<style>
.progress-bar {
  transition-property: all;
  transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
  transition-duration: 1s;
}
</style>

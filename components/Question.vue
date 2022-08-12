<template>
  <div class="flex h-full flex-col items-center justify-center">
    <h1
      class="mb-10 mt-8 text-center text-3xl font-bold italic md:mt-0"
      style="word-break: break-word"
    >
      {{ question.title }}
    </h1>
    <div class="mb-10 flex w-full items-center justify-center">
      <div class="h-20 w-20">
        <button v-if="electionQuizStore.step !== 0" @click="previousStep">
          <RewindIcon class="block h-20 w-20 text-yellow-600" />
        </button>
      </div>
      <button>
        <ThumbUpIcon
          class="block h-20 w-20 text-green-500"
          @click="updateAnswer('yay')"
        />
      </button>
      <button>
        <ThumbDownIcon
          class="block h-20 w-20 text-red-500"
          @click="updateAnswer('nay')"
        />
      </button>
      <div class="h-20 w-20">
        <button
          v-if="electionQuizStore.step < electionQuizStore.quiz.length"
          @click="nextStep"
        >
          <FastForwardIcon class="block h-20 w-20 text-yellow-600" />
        </button>
      </div>
    </div>
    <div class="hidden md:block">
      <a
        :href="question.link"
        target="_blank"
        type="button"
        class="inline-flex items-center rounded-full border border-transparent bg-gray-700 px-5 py-2 text-base font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
      >
        LÆS MERE OM FORSLAGET
      </a>
    </div>
  </div>
</template>

<script setup lang="ts">
import {
  ThumbUpIcon,
  ThumbDownIcon,
  RewindIcon,
  FastForwardIcon,
} from '@heroicons/vue/solid/esm/index.js'
import { useElectionQuizStore } from '@/stores/electionQuiz'

const electionQuizStore = useElectionQuizStore()

const question = computed(() => {
  return electionQuizStore.quiz[electionQuizStore.step]
})

const nextStep = () => {
  electionQuizStore.nextStep()
}

const previousStep = () => {
  electionQuizStore.previousStep()
}

const updateAnswer = (answer: string) => {
  electionQuizStore.reply(answer)
  saveAnswer(answer)
  if (!electionQuizStore.hasScrolled) {
    electionQuizStore.setScroll(true)
    document
      .getElementById('quiz-progress')
      ?.scrollIntoView({ block: 'start', behavior: 'smooth' })
  }
}

const saveAnswer = (answer: string) => {
  fetch('/api/vote', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      title: electionQuizStore.quiz[electionQuizStore.step].title,
      ftid: electionQuizStore.quiz[electionQuizStore.step].ftid,
      samling: electionQuizStore.quiz[electionQuizStore.step].samling,
      vote: answer,
    }),
  })
}
</script>

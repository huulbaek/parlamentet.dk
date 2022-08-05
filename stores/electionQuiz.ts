import { defineStore } from 'pinia'
import electionData from '@/assets/data/electionData.json'
import metaData from '@/assets/data/metaData.json'

interface Party {
  initials: string
  color: string
  logo: string
  agreements: number
}

interface IObjectKeys {
  [key: string]: any
}

interface Election extends IObjectKeys {
  ftid: string
  samling: string
  link: string
  title: string
  yay: Array<string>
  nay: Array<string>
  absent_or_maybe: Array<string>
  answer: string
}

export const useElectionQuizStore = defineStore('electionQuiz', {
  state: () => ({
    quiz: electionData as Election[],
    step: 0,
    parties: metaData.parties,
  }),
  actions: {
    reply(answer: string) {
      this.quiz[this.step].answer = answer
      const initials: Array<string> = this.quiz[this.step][answer]
      this.parties.forEach((party) => {
        if (initials.includes(party.initials)) {
          party.agreements++
        }
      })
      if (this.step < this.quiz.length - 1) {
        this.step++
      }
    },
    nextStep() {
      this.step++
    },
    previousStep() {
      this.step--
    },
  },
  getters: {
    quizResult(): Array<Party> {
      const parties = metaData.parties
      parties.forEach((party) => {
        party.agreements = 0
      })
      this.quiz.forEach((item) => {
        if (item.answer !== '') {
          item[item.answer].forEach((initial: string) => {
            parties.forEach((party) => {
              if (party.initials === initial) {
                party.agreements++
              }
            })
          })
        }
      })
      return parties
    },
  },
})

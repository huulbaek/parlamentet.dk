import { defineStore } from 'pinia'
import electionData from '@/assets/data/electionData.json'
import metaData from '@/assets/data/metaData.json'

interface Party {
  initials: string
  color: string
  logo: string
  agreements: number
  disagreements: number
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

function shuffleArray(arr: Party[]): Party[] {
  const array = arr
  for (let i = array.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1))
    ;[array[i], array[j]] = [array[j], array[i]]
  }
  return array
}

export const useElectionQuizStore = defineStore('electionQuiz', {
  state: () => ({
    quiz: electionData as Election[],
    step: 0,
    parties: shuffleArray(metaData.parties),
    hasScrolled: false,
  }),
  actions: {
    reply(answer: string) {
      this.quiz[this.step].answer = answer
      if (this.step < this.quiz.length) {
        this.step++
      }
    },
    nextStep() {
      this.step++
    },
    previousStep() {
      this.step--
    },
    setScroll(val: boolean) {
      this.hasScrolled = val
    },
  },
  getters: {
    quizResult(): Array<Party> {
      const parties = this.parties
      parties.forEach((party) => {
        party.agreements = 0
        party.disagreements = 0
      })
      this.quiz.forEach((item) => {
        if (item.answer !== '') {
          const agreedInitials = item[item.answer]
          const allInitials = item.yay.concat(item.nay)
          // .concat(item.absent_or_maybe)
          parties.forEach((party) => {
            if (agreedInitials.includes(party.initials)) {
              party.agreements++
            } else if (allInitials.includes(party.initials)) {
              party.disagreements++
            }
          })
        }
      })
      return parties
    },
    sortedQuizResult(): Array<Party> {
      return [...this.quizResult].sort((a, b) => {
        let aaa = a.agreements / (a.disagreements + a.disagreements)
        let bbb = b.agreements / (b.disagreements + b.disagreements)
        if (a.agreements + a.disagreements === 0) {
          aaa = 0
        }
        if (b.agreements + b.disagreements === 0) {
          bbb = 0
        }
        return bbb - aaa
      })
    },
  },
})

export type { Party }

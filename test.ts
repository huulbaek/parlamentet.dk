import { afstemningGet, createContext } from './utils/oda'

const ctx = createContext()

afstemningGet(ctx, {}).then((afstemning) => {
  console.log(afstemning)
})

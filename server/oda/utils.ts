import fs from 'fs'
import path from 'path'

// Define the path to the file where the timestamp will be stored
const timestampFilePath = path.resolve(__dirname, 'lastUpdateTimestamp.txt')

export async function loadLastUpdateTimestamp(): Promise<Date> {
  try {
    const timestampStr = await fs.promises.readFile(timestampFilePath, 'utf-8')
    return new Date(timestampStr)
  } catch (error) {
    // If the file does not exist, return a date far in the past
    return new Date(0)
  }
}

export async function saveLastUpdateTimestamp(timestamp: Date): Promise<void> {
  await fs.promises.writeFile(timestampFilePath, timestamp.toISOString())
}

#!/usr/bin/env node

const { updateSag } = require('../server/oda/fetchAndStoreSag')

const command = process.argv[2]

if (command === 'updateSag') {
  updateSag()
} else {
  console.log('Unknown command')
}

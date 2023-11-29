<template>
  <div class="bg-gradient-to-r from-gray-700 via-gray-900 to-black pb-32">
    <Disclosure
      v-slot="{ open }"
      as="nav"
      class="bg-gradient-to-r from-gray-700 via-gray-900 to-black"
    >
      <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
        <div class="border-b border-gray-200">
          <div class="flex h-16 items-center justify-between px-4 sm:px-0">
            <div class="flex items-center">
              <div class="flex-shrink-0">
                <NuxtLink to="/">
                  <img
                    class="h-8 w-8"
                    src="/favicon.png"
                    alt="Parlamentet.dk logo"
                  />
                </NuxtLink>
              </div>
              <div class="hidden md:block">
                <div class="ml-10 flex items-baseline space-x-4">
                  <NuxtLink
                    v-for="item in navigation"
                    :key="item.name"
                    :to="item.href"
                    class="$rounded-md px-3 py-2 text-sm font-medium text-gray-300 hover:bg-gray-700 hover:text-white"
                    >{{ item.name }}</NuxtLink
                  >
                </div>
              </div>
            </div>
            <ColorModeButton />
            <div class="hidden md:block">
              <div class="ml-4 flex items-center md:ml-6">
                <a href="https://github.com/huulbaek/parlamentet.dk">
                  <img src="/github.png" class="h-8" alt="Github logo" />
                </a>
              </div>
            </div>
            <div class="-mr-2 flex md:hidden">
              <DisclosureButton
                class="inline-flex items-center justify-center rounded-md bg-gray-800 p-2 text-gray-400 hover:bg-gray-700 hover:text-white focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800"
              >
                <span class="sr-only">Open main menu</span>
                <MenuIcon
                  v-if="!open"
                  class="block h-6 w-6"
                  aria-hidden="true"
                />
                <XIcon v-else class="block h-6 w-6" aria-hidden="true" />
              </DisclosureButton>
            </div>
          </div>
        </div>
      </div>

      <DisclosurePanel class="border-b border-gray-700 md:hidden">
        <div class="space-y-1 px-2 py-3 sm:px-3">
          <DisclosureButton
            v-for="item in navigation"
            :key="item.name"
            as="a"
            :href="item.href"
            class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white"
            >{{ item.name }}</DisclosureButton
          >
        </div>
      </DisclosurePanel>
    </Disclosure>
    <header class="py-10">
      <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <Transition name="title" mode="out-in">
          <h1
            :key="mainStore.headerTitle"
            class="tracking-tighest mt-1 bg-gradient-to-r from-pink-500 via-red-500 to-yellow-500 bg-clip-text text-4xl font-extrabold uppercase text-transparent sm:text-5xl lg:text-7xl"
          >
            <span>{{ mainStore.headerTitle }}</span>
          </h1>
        </Transition>
      </div>
    </header>
  </div>
</template>

<script setup lang="ts">
import { Disclosure, DisclosureButton, DisclosurePanel } from '@headlessui/vue'
import { MenuIcon, XIcon } from '@heroicons/vue/outline/esm/index.js'
import { useMainStore } from '@/stores/main'

const mainStore = useMainStore()

const navigation = [
  { name: 'Om Parlamentet', href: '/' },
  { name: 'Valgtest', href: '/folketingsvalg-2022-valgtest' },
  { name: 'Lovforslag', href: '/lovforslag' },
]
</script>

<style>
.title-enter-active {
  animation: title-in 0.5s;
}
.title-leave-active {
  animation: title-in 0.5s reverse;
}
@keyframes title-in {
  0% {
    transform: translateX(-100%);
  }
  100% {
    transform: translateX(0);
  }
}
</style>

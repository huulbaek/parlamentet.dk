const elections = [
  '/data/folketingsvalg-2019/',
  '/data/folketingsvalg-2015',
  '/data/folketingsvalg-2016',
]

export default defineNuxtRouteMiddleware((to) => {
  if (elections.includes(to.path)) {
    return navigateTo('/folketingsvalg-2022-valgtest', { redirectCode: 301 })
  }
})

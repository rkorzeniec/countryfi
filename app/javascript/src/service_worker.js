console.log('ServiceWorker imported')

if ('serviceWorker' in navigator) {
  window.addEventListener('load', () => {
    navigator.serviceWorker.register('/service-worker.js', { scope: '/' }).then(registration => {
      console.log('[Service worker] Registered: ', registration)
    }).catch(registrationError => {
      console.log('[Service worker] Registration failed: ', registrationError)
    })
  })
}

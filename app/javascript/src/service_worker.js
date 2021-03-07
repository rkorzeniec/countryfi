if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('/service-worker.js', { scope: '/' }).then(registration => {
    // console.log('[Service worker] Registered: ', registration)
  }).catch(registrationError => {
    // console.log('[Service worker] Registration failed: ', registrationError)
  })
}

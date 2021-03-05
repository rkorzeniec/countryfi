// JS inline imports
import Rails from 'rails-ujs'
import Turbolinks from 'turbolinks'

// styles imports
import 'styles/site'

Rails.start()
Turbolinks.start()

// initialize service workers
if ('serviceWorker' in navigator) {
  window.addEventListener('load', () => {
    navigator.serviceWorker.register('/service-worker.js', { scope: '/' }).then(registration => {
      console.log('[Service worker] Registered: ', registration)
    }).catch(registrationError => {
      console.log('[Service worker] Registration failed: ', registrationError)
    })
  })
}

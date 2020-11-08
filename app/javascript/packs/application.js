// JS inline imports
import Rails from 'rails-ujs'
import Turbolinks from 'turbolinks'

// styles imports
import 'styles/site'

Rails.start()
Turbolinks.start()

// initialise service workers
window.addEventListener('load', () => {
  navigator.serviceWorker.register('/service-worker.js').then(registration => {
    console.log('ServiceWorker registered: ', registration)

    let serviceWorker
    if (registration.installing) {
      serviceWorker = registration.installing
      console.log('Service worker installing.')
    } else if (registration.waiting) {
      serviceWorker = registration.waiting
      console.log('Service worker installed & waiting.')
    } else if (registration.active) {
      serviceWorker = registration.active
      console.log('Service worker active.')
    }
  }).catch(registrationError => {
    console.log('Service worker registration failed: ', registrationError)
  })
})

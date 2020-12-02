import 'popper.js'
import 'jquery'
import 'bootstrap/js/dist/util'
import 'bootstrap/js/dist/collapse'
import 'bootstrap/js/dist/dropdown'
import 'bootstrap/js/dist/modal'
import 'bootstrap/js/dist/tooltip'

/* eslint-disable no-undef */
// DOM events initialisation
const worldSvgCountries = $("#world-svg-map [data-toggle='tooltip']")
worldSvgCountries.tooltip({
  container: 'body',
  placement: 'right',
  trigger: 'hover',
  template: "<div class='tooltip' role='tooltip'><div class='tooltip-inner'></div></div>"
})

worldSvgCountries.on('mousedown', (e) => $(e.currentTarget).tooltip('hide'))
worldSvgCountries.on('mouseup', (e) => $(e.currentTarget).tooltip('show'))

$('#overlay').modal('show')
/* eslint-enable no-undef */

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

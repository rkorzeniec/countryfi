// JS inline imports
import Rails from 'rails-ujs'
import Turbolinks from 'turbolinks'
import 'bootstrap'
import 'jquery'

// styles imports
import 'styles/site'

// JS async imports
import('src/imports/application')

Rails.start()
Turbolinks.start()

/* eslint-disable no-undef */
// DOM events initialisation
document.addEventListener('turbolinks:load', () => {
  const worldSvgCountries = $("#world-svg-map [data-toggle='tooltip']")
  worldSvgCountries.tooltip({
    container: 'body',
    placement: 'right',
    trigger: 'hover',
    template: "<div class='tooltip' role='tooltip'><div class='tooltip-inner'></div></div>"
  })

  worldSvgCountries.on('mousedown', (e) => $(e.currentTarget).tooltip('hide'))
  worldSvgCountries.on('mouseup', (e) => $(e.currentTarget).tooltip('show'))
})
/* eslint-enable no-undef */

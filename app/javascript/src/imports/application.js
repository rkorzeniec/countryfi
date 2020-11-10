import 'jquery'
import 'popper.js'
import 'controllers'

/* eslint-disable no-undef */
window.$ = $

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

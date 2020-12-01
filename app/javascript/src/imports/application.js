import 'popper.js'
import 'controllers'
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

// JS inline imports
import Rails from 'rails-ujs';
import Turbolinks from 'turbolinks';
import 'bootstrap';

// JS async imports
import('src/imports/application');

// styles imports
import 'styles/site';

window.$ = $;
Rails.start();
Turbolinks.start();

// DOM events initialisation
document.addEventListener("turbolinks:load", () => {
  const worldSvgCountries = $('#world-svg-map [data-toggle="tooltip"]');
  worldSvgCountries.tooltip({
    container: 'body',
    placement: 'right',
    trigger: 'hover',
    template: '<div class="tooltip" role="tooltip"><div class="tooltip-inner"></div></div>'
  })

  worldSvgCountries.on('mousedown', (e) => $(e.currentTarget).tooltip('hide'))
  worldSvgCountries.on('mouseup', (e) => $(e.currentTarget).tooltip('show'))
})

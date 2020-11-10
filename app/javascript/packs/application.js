// js
import Rails from 'rails-ujs';
import Turbolinks from 'turbolinks';
import('jquery');
import('popper.js');
import('bootstrap');
import('controllers');

// stylesheets
import 'stylesheets/site';

//custom window bindings
window.$ = $;

Rails.start();
Turbolinks.start();

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

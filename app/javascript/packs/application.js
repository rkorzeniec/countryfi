// js
import Rails from 'rails-ujs';
import Turbolinks from 'turbolinks';
import 'jquery';
import 'popper.js';
import 'bootstrap';

// custom scripts
import { flashTimeout } from '../src/flash'

// css
import 'css/site';

window.$ = $;
Rails.start();
Turbolinks.start();

//custom window bindings
window.flashTimeout = flashTimeout

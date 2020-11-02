// js
import Rails from 'rails-ujs';
import Turbolinks from 'turbolinks';
import 'jquery';
import 'popper.js';
import 'bootstrap';
import 'controllers';

// custom scripts
import { flashTimeout } from '../src/flash';

// css
import 'css/site';

//custom window bindings
window.$ = $;
window.flashTimeout = flashTimeout;

Rails.start();
Turbolinks.start();

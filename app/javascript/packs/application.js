// js
import Rails from 'rails-ujs';
import Turbolinks from 'turbolinks';
import 'jquery';
import 'popper.js';
import 'bootstrap';

// custom scripts
import { Notifications } from '../src/notifications';
import { flashTimeout } from '../src/flash';

// css
import 'css/site';

//custom window bindings
window.$ = $;
window.flashTimeout = flashTimeout;

Rails.start();
Turbolinks.start();
new Notifications();

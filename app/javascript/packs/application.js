// js
import Rails from 'rails-ujs';
import Turbolinks from 'turbolinks';

import('src/plugins');

// css
import 'css/site';

window.$ = $;
Rails.start();
Turbolinks.start();

// JS inline imports
import Rails from 'rails-ujs'
import Turbolinks from 'turbolinks'

// styles imports
import 'styles/site'

// JS async imports
import('src/service_worker')

Rails.start()
Turbolinks.start()

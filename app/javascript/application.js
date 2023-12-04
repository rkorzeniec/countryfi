import "@hotwired/turbo-rails"
import "flowbite/dist/flowbite.turbo.js";
import "./controllers"
import "./src/service_worker"


import { Application } from '@hotwired/stimulus'
import { Dropdown } from 'tailwindcss-stimulus-components'
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers"
import 'chartkick/chart.js'

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

application.register('dropdown', Dropdown)


window.Stimulus = Application.start()
const context = require.context("./controllers", true, /\.js$/)
Stimulus.load(definitionsFromContext(context))

export { application }

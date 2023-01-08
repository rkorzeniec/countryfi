import { Application } from '@hotwired/stimulus'
import { Dropdown } from 'tailwindcss-stimulus-components'
import Popover from 'stimulus-popover'

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

application.register('dropdown', Dropdown)
application.register('popover', Popover)

export { application }

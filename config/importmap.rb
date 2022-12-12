# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true

pin '@hotwired/stimulus', to: '@hotwired--stimulus.js' # @3.2.1
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin 'tailwindcss-stimulus-components' # @3.0.4
pin_all_from 'app/javascript/controllers', under: 'controllers'

pin '@hotwired/turbo-rails', to: '@hotwired--turbo-rails.js' # @7.2.4
pin '@hotwired/turbo', to: '@hotwired--turbo.js' # @7.2.4
pin '@rails/actioncable/src', to: '@rails--actioncable--src.js' # @7.0.4
pin "svg-pan-zoom" # @3.6.1

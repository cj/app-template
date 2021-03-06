// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import '../channels'
import '../controllers'
import '../time_zone'
// import '../components'
import 'popper.js'
import 'bootstrap'
import '../stylesheets/application.scss'

import * as ActiveStorage from '@rails/activestorage'

import { Turbo } from '@hotwired/turbo-rails'
// import Rails from '@rails/ujs'
// import Turbolinks from 'turbolinks'
import debounced from 'debounced'

// Rails.start()
// Turbolinks.start()
ActiveStorage.start()
debounced.initialize()
Turbo.start()

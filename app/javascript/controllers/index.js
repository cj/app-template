import { Application } from 'stimulus'
import StimulusReflex from 'stimulus_reflex'
import { definitionsFromContext } from 'stimulus/webpack-helpers'
import consumer from '../channels/consumer'
import controller from './application_controller'

const application = Application.start()
const context = require.context('.', true, /_controller\.js$/)
const contextComponents = require.context('../../components', true, /_controller.js$/)

application.load(definitionsFromContext(context).concat(definitionsFromContext(contextComponents)))
StimulusReflex.initialize(application, { consumer, controller, isolate: true })
StimulusReflex.debug = process.env.RAILS_ENV === 'development'

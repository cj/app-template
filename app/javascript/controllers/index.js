import { Application } from 'stimulus'
import StimulusReflex from 'stimulus_reflex'
// import { definitionsFromContext } from 'stimulus/webpack-helpers'
import consumer from '../channels/consumer'
import controller from './application_controller'

const application = Application.start()
const context = require.context('.', true, /_controller\.js$/)
const contextComponents = require.context('../../components', true, /.js$/)

function identifierForContextKey(key) {
  const logicalName = (key.match(/^(?:\.\/)?(.+)(?:([_-]controller|)\..+?)$/) || [])[1]

  if (logicalName) {
    return logicalName.replace(/_/g, '-').replace(/\//g, '--')
  }

  return null
}

function definitionForModuleAndIdentifier(module, identifier) {
  const controllerConstructor = module.default

  if (typeof controllerConstructor === 'function') {
    return { identifier, controllerConstructor }
  }

  return null
}

function definitionForModuleWithContextAndKey(ctx, key) {
  const identifier = identifierForContextKey(key)
  if (identifier) {
    return definitionForModuleAndIdentifier(ctx(key), identifier)
  }

  return null
}

function definitionsFromContext(ctx) {
  return ctx
    .keys()
    .map((key) => definitionForModuleWithContextAndKey(ctx, key))
    .filter((value) => value)
}

application.load(definitionsFromContext(context).concat(definitionsFromContext(contextComponents)))
StimulusReflex.initialize(application, { consumer, controller, isolate: true })
StimulusReflex.debug = process.env.RAILS_ENV === 'development'

// https://github.com/danieldiekmeier/stimulus-controller-resolver
import { Application } from 'stimulus'
// import { definitionsFromContext } from 'stimulus/webpack-helpers'

const application = Application.start()
const context = require.context('.', true, /_controller\.js$/)
// This makes it load with dynamic import()
// const contextComponents = require.context('../../components', true, /.js$/, 'lazy')
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

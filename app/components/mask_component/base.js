import ApplicationController from '~/controllers/application_controller'

export default class extends ApplicationController {
  connect() {
    this.masks().forEach((element) => {
      const { tagName } = element

      switch (tagName) {
        case 'A':
          this.handleLink(element)
          break
        default:
          throw new Error(`Please add handler for ${tagName}`)
      }
    })
  }

  // handleLink(element) {}

  masks() {
    return this.element.querySelectorAll('[data-mask]')
  }
}

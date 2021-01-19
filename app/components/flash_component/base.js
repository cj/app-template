import './base.scss'

import { Toast } from 'bootstrap'
import ApplicationController from '~/controllers/application_controller'
import { events } from '~/events'

export default class extends ApplicationController {
  static values = { container: String }

  connect() {
    if (this.containerValue) {
      events.on('flash', this.handleEvents)
      return
    }

    this.toast = new Toast(this.element)
    this.toast.show()

    this.element.addEventListener('hidden.bs.toast', () => {
      this.element.remove()
    })
  }

  disconnect() {
    if (!this.containerValue) return

    events.off('flash', this.handleEvents)
  }

  close() {
    this.toast.close()
  }

  handleEvents = ({ type, header, message }) => {
    const { flashContainer } = this

    flashContainer.appendChild(this.template({ type, header, message }))
  }

  get flashContainer() {
    return document.querySelector(this.containerValue)
  }

  static alertClass(type) {
    switch (type) {
      case 'error':
        return 'danger'
      case 'alert':
        return 'warning'
      case 'notice':
        return 'info'
      default:
        return type
    }
  }

  template = ({ type, header, message }) => {
    this.templateElement =
      this.templateElement || document.querySelector(`${this.containerValue}_template`)

    const template = this.templateElement.cloneNode(true).content

    template.querySelector('.flash-template-header').innerHTML = header
    template.querySelector('.flash-template-message').innerHTML = message
    template
      .querySelector('.flash-template-icon')
      .classList.add(`text-${this.constructor.alertClass(type)}`)

    return template
  }
}

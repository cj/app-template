import './base.scss'

import { Toast } from 'bootstrap'
import ApplicationController from '~/controllers/application_controller'

export default class extends ApplicationController {
  connect() {
    this.toast = new Toast(this.element)
    this.toast.show()

    this.element.addEventListener('hidden.bs.toast', () => {
      this.element.remove()
    })
  }

  close() {
    this.toast.close()
  }
}

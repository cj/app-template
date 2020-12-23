import './base.scss'

import { Alert } from 'bootstrap'
import ApplicationController from '~/controllers/application_controller'

export default class extends ApplicationController {
  connect() {
    this.alert = new Alert(this.element)
  }

  close() {
    this.alert.close()
  }
}

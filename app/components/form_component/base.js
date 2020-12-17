import { capitalize, debounce } from 'lodash'

/* eslint-disable class-methods-use-this, no-param-reassign */
import { Controller } from 'stimulus'
import { I18n } from '~/i18n'

const ERROR_CLASS = 'invalid-feedback'
const ERROR_TAG = 'div'

const INPUT_ERROR_CLASS = 'is-invalid'
const INPUT_VALID_CLASS = 'is-valid'
const INPUT_BLACKLIST = ['file', 'reset', 'submit', 'button']
const INPUT_CONTAINER = 'form-group'
const INPUT_ERROR_FIELD_NAME = 'data-error-field-name'

const VALIDITY_TYPES = [
  'badInput',
  'customError',
  'patternMismatch',
  'rangeOverflow',
  'rangeUnderflow',
  'stepMismatch',
  'tooLong',
  'tooShort',
  'typeMismatch',
  'valid',
  'valueMissing',
]

const ACTIVE_MODEL_ERRORS_TYPE_MAP = {
  valueMissing: 'blank',
  typeMismatch: 'invalid',
}

export default class extends Controller {
  connect() {
    const { form, onKeyPress, onSubmit, onAjaxSuccess, onAjaxComplete, onAjaxError, onFocus } = this

    this.firstInvalidField.focus()

    form.dataset.remote = true
    form.setAttribute('novalidate', true)
    form.addEventListener('keydown', onKeyPress)
    form.addEventListener('focusout', onFocus)
    form.addEventListener('submit', onSubmit)
    form.addEventListener('ajax:success', onAjaxSuccess)
    form.addEventListener('ajax:complete', onAjaxComplete)
    form.addEventListener('ajax:error', onAjaxError)
  }

  disconnect() {
    const { form, onKeyPress, onSubmit, onAjaxSuccess, onAjaxComplete, onAjaxError, onFocus } = this

    form.removeEventListener('keydown', onKeyPress)
    form.removeEventListener('focusout', onFocus)
    form.removeEventListener('submit', onSubmit)
    form.removeEventListener('ajax:success', onAjaxSuccess)
    form.removeEventListener('ajax:complete', onAjaxComplete)
    form.removeEventListener('ajax:error', onAjaxError)
  }

  onAjaxError = (event) => {
    const [, , request] = event.detail

    const { response } = request

    if (response.substring(0, 10) === 'Turbolinks') {
      return
    }

    Turbolinks.clearCache()

    try {
      // eslint-disable-next-line prefer-destructuring
      document.body.innerHTML = response.match(/<body[^>]*>([\s\S]*?)<\/body>/i)[1]

      Turbolinks.dispatch('turbolinks:load')

      window.scroll(0, 0)
    } catch {
      //
    }
  }

  onFocus = (event) => {
    this.validateField(event.target, 'focus')
  }

  onKeyPress = debounce((event) => this.validateField(event.target, 'press'), 250)

  onSubmit = (event) => {
    if (this.validateForm() && this.form.method !== 'get') {
      Turbolinks.controller.history.push(window.location.href)
    } else {
      event.preventDefault() // do not perform regular sumbit
      event.stopPropagation() // do not let regular remote handler see this

      this.firstInvalidField.focus()
    }
  }

  onAjaxSuccess = (event) => {
    const [, , request] = event.detail

    this.completed = true

    this.resetting = true
    this.form.reset()
    this.resetting = false

    Turbolinks.clearCache()

    Turbolinks.visit(request.responseURL)
  }

  // onAjaxComplete = () => {
  //   // If the form was submitted via ajax we want to focus on the first error returned.
  //   this.firstInvalidField.focus()
  // }

  validateForm() {
    if (this.resetting) return true

    let isValid = true

    // Not using `find` because we want to validate all the fields
    this.formFields.forEach((field) => {
      if (this.shouldValidateField(field) && !this.validateField(field)) isValid = false
    })

    return isValid
  }

  validateField(field, eventType = null) {
    if (
      !this.shouldValidateField(field) ||
      !field.hasAttribute('required') ||
      this.resetting ||
      ((!eventType || eventType === 'focus') && field.classList.contains('is-server-error'))
    ) {
      return true
    }

    const isValid = field.checkValidity()

    field.classList.toggle(INPUT_ERROR_CLASS, !isValid)

    this.refreshErrorForInvalidField(field, isValid)

    if (isValid) {
      field.classList.add(INPUT_VALID_CLASS)
    }

    return isValid
  }

  shouldValidateField = (field) =>
    !field.disabled && !INPUT_BLACKLIST.includes(field.type) && field.willValidate

  refreshErrorForInvalidField(field, isValid) {
    const fieldContainer = field.closest(`.${INPUT_CONTAINER}`)

    this.removeExistingErrorMessage(field, fieldContainer)

    if (!isValid) {
      this.showErrorForInvalidField(field, fieldContainer)
    }
  }

  removeExistingErrorMessage(_field, fieldContainer) {
    if (!fieldContainer) {
      return
    }

    const existingErrorMessageElement = fieldContainer.querySelector(`.${ERROR_CLASS}`)

    if (existingErrorMessageElement && existingErrorMessageElement.parentNode) {
      try {
        existingErrorMessageElement.parentNode.removeChild(existingErrorMessageElement)
      } catch {
        // We do not care about "The node to be removed is not a child of this node."
      }
    }
  }

  showErrorForInvalidField(field, fieldContainer) {
    if (!fieldContainer) {
      return
    }

    const existingErrorMessageElement = fieldContainer.querySelector(`.${ERROR_CLASS}`)

    if (!existingErrorMessageElement) {
      field.insertAdjacentHTML('afterend', this.buildFieldErrorHtml(field))
    }
  }

  setLabelError(label, field) {
    const dataLabelHTML = label.dataset.labelHTML
    const labelHTML = dataLabelHTML || label.innerHTML
    const errorMessage = this.getFieldErrorMessage(field)

    if (!dataLabelHTML) label.dataset.labelHTML = dataLabelHTML

    label.innerHTML = `${labelHTML} ${errorMessage}`
    label.classList.add('text-danger')
  }

  buildFieldErrorHtml(field) {
    const errorMessage = this.getFieldErrorMessage(field)
    return `<${ERROR_TAG} class="${ERROR_CLASS}">${errorMessage}</${ERROR_TAG}>`
  }

  getFieldErrorMessage(field) {
    const { validity, validationMessage, name } = field
    const htmlErrorType = VALIDITY_TYPES.find((type) => validity[type])
    const messageKey = ACTIVE_MODEL_ERRORS_TYPE_MAP[htmlErrorType]

    let errorField = field.getAttribute(INPUT_ERROR_FIELD_NAME)

    if (!errorField) {
      errorField = name
        .trim()
        // Extract the field from the name i.e. project[description] becomes description
        .replace(/.+\b(\w+)(?:\S|)$/i, '$1')
        // Replace any none word with a space i.e. Password_confirmation becomes Password confirmation
        .replace(/[^a-z]/i, ' ')
        // cleanup spaces
        .replace(/\s{2,}/i, ' ')

      errorField = capitalize(errorField)

      field.setAttribute(INPUT_ERROR_FIELD_NAME, errorField)
    }

    const i18nMessage = I18n.t(`errors.messages.${messageKey}`, {
      defaultValue: validationMessage,
    })

    const errorMessage = `${errorField} ${i18nMessage}`

    return errorMessage
  }

  get formFields() {
    return Array.from(this.element.elements)
  }

  get firstInvalidField() {
    return (
      this.formFields.find(
        (field) => !field.checkValidity() || field.classList.contains(INPUT_ERROR_CLASS),
      ) || { focus: () => null }
    )
  }

  get form() {
    return this.element
  }
}

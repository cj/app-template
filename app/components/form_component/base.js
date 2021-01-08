import { capitalize, debounce } from 'lodash'

/* eslint-disable class-methods-use-this, no-param-reassign */
import { Controller } from 'stimulus'

// import { Turbo } from '@hotwired/turbo-rails'

// import StimulusReflex from 'stimulus_reflex'

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

const waitFor = async (condFunc) =>
  new Promise((resolve) => {
    if (condFunc()) {
      resolve()
    } else {
      setTimeout(async () => {
        // eslint-disable-next-line no-unused-vars
        await waitFor(condFunc)
        resolve()
      }, 100)
    }
  })

export default class extends Controller {
  connect() {
    const { form, onKeyPress, onSubmit, onFocus, resetForm, handleTurboEnd } = this

    this.firstInvalidField.focus()

    // form.dataset.remote = true
    form.setAttribute('novalidate', true)

    document.addEventListener('turbo:before-cache', resetForm)
    document.addEventListener('turbo:submit-end', handleTurboEnd)
    // document.addEventListener('turbo:submit-end', async (event) => {
    //   const html = await event.detail.fetchResponse.responseHTML
    //   document.open()
    //   document.write(html)
    //   document.close()
    //   Turbo.load()
    // })
    form.addEventListener('keydown', onKeyPress)
    form.addEventListener('focusout', onFocus)
    form.addEventListener('submit', onSubmit)
  }

  disconnect() {
    const { form, onKeyPress, onSubmit, onFocus, resetForm, handleTurboEnd } = this

    document.removeEventListener('turbo:before-cache', resetForm)
    document.removeEventListener('turbo:submit-end', handleTurboEnd)
    form.removeEventListener('keydown', onKeyPress)
    form.removeEventListener('focusout', onFocus)
    form.removeEventListener('submit', onSubmit)
  }

  onFocus = (event) => {
    this.validateField(event.target, 'focus')
  }

  onKeyPress = debounce((event) => {
    this.validateField(event.target, event.which === 9 ? 'focus' : 'press')
  }, 250)

  onSubmit = async (event) => {
    this.disabledSubmit()

    if (!this.validateForm()) {
      event.preventDefault() // do not perform regular sumbit
      event.stopPropagation() // do not let regular remote handler see this

      this.firstInvalidField.focus()

      this.enableSubmit()
    }
  }

  enableSubmit() {
    this.form.querySelectorAll('button[type="submit"]').forEach((element) => {
      element.disabled = false

      const spinner = element.querySelector('.spinner')

      if (spinner) {
        spinner.remove()
      }
    })
  }

  disabledSubmit() {
    this.form.querySelectorAll('button[type="submit"]').forEach((element) => {
      element.disabled = true
      element.insertBefore(this.createSpinner(), element.firstChild)
    })
  }

  handleTurboEnd = (event) => {
    const { success } = event.detail

    if (!success) {
      this.enableSubmit()
    }
  }

  resetForm = () => {
    this.formFields.forEach((field) => {
      // const fieldType = field.type.toLowerCase()
      //
      // switch (fieldType) {
      //   case 'text':
      //   case 'password':
      //   case 'textarea':
      //   case 'hidden':
      //     field.value = ''
      //     break
      //
      //   case 'radio':
      //   case 'checkbox':
      //     if (field.checked) {
      //       field.checked = false
      //     }
      //     break
      //
      //   case 'select-one':
      //   case 'select-multi':
      //     field.selectedIndex = -1
      //     break
      //
      //   default:
      //     break
      // }

      field.blur()
      field.classList.remove('is-valid')
    })

    this.form.querySelectorAll('.alert').forEach((element) => element.remove())
    this.enableSubmit()
  }

  createSpinner() {
    const spinner = document.createElement('span')

    spinner.className = 'spinner spinner-border spinner-border-sm me-2'
    spinner.role = 'status'
    spinner['aria-hidden'] = true

    return spinner
  }

  validateForm() {
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

  async showErrorForInvalidField(field, fieldContainer) {
    if (!fieldContainer) {
      return
    }

    const existingErrorMessageElement = fieldContainer.querySelector(`.${ERROR_CLASS}`)

    if (!existingErrorMessageElement) {
      field.insertAdjacentHTML('afterend', await this.buildFieldErrorHtml(field))
    }
  }

  async setLabelError(label, field) {
    const dataLabelHTML = label.dataset.labelHTML
    const labelHTML = dataLabelHTML || label.innerHTML
    const errorMessage = await this.getFieldErrorMessage(field)

    if (!dataLabelHTML) label.dataset.labelHTML = dataLabelHTML

    label.innerHTML = `${labelHTML} ${errorMessage}`
    label.classList.add('text-danger')
  }

  async buildFieldErrorHtml(field) {
    const errorMessage = await this.getFieldErrorMessage(field)
    return `<${ERROR_TAG} class="${ERROR_CLASS}">${errorMessage}</${ERROR_TAG}>`
  }

  async getFieldErrorMessage(field) {
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

    const i18nMessage = (await this.I18n()).t(`errors.messages.${messageKey}`, {
      defaultValue: validationMessage,
    })

    const errorMessage = `${errorField} ${i18nMessage}`

    return errorMessage
  }

  async I18n() {
    const { I18n } = await import('~/i18n')

    return I18n
  }

  get formFields() {
    return Array.from(this.element.elements)
  }

  get firstInvalidField() {
    return (
      this.formFields.find((field) => field.classList.contains(INPUT_ERROR_CLASS)) || {
        focus: () => null,
      }
    )
  }

  get form() {
    return this.element
  }
}

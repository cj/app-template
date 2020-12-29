// import ApplicationController from '~/controllers/application_controller'
//
// export default class extends ApplicationController {
//   connect() {
//     this.initAutocomplete()
//   }
//
//   async initAutocomplete() {
//     this.Autocomplete = import('~/mdb/autocomplete')
//
//     const { element } = this
//
//     if (element.type === 'select-one') {
//       this.loadFromSelect()
//     }
//   }
//
//   async loadFromSelect() {
//     const data = []
//     let selected = ''
//
//     const { element, Autocomplete } = this
//
//     this.element.querySelectorAll('option').forEach((option) => {
//       const { value, text } = option
//
//       if (option.selected) {
//         selected = value
//       }
//
//       data.push({ text, value })
//     })
//
//     const dataFilter = (currentValue) =>
//       data.filter(({ value }) => value.toLowerCase().startsWith(currentValue.toLowerCase()))
//
//     const input = document.createElement('input')
//
//     input.classList = element.classList
//     input.id = element.id
//     input.value = selected
//
//     const formGroup = element.closest('.form-group')
//
//     this.element.replaceWith(input)
//
//     // eslint-disable-next-line new-cap
//     this.autocomplete = new (await Autocomplete).default(formGroup, {
//       filter: dataFilter,
//       displayValue: ({ text }) => text,
//     })
//   }
// }

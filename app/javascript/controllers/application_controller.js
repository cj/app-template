import { Controller } from 'stimulus'

export default class ApplicationController extends Controller {
  // eslint-disable-next-line class-methods-use-this
  get I18n() {
    return (async () => {
      const { I18n } = await import('~/i18n')

      return I18n
    })()
  }

  async t(...args) {
    return (await this.I18n).t(...args)
  }
}

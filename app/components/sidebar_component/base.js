import './base.scss'

import VanillaSwipe from 'vanilla-swipe'
import ApplicationController from '~/controllers/application_controller'

const SIDEBAR_BREAKPOINT = '--bs-breakpoint-lg'
const OPEN_CLASS = 'open'
const OPEN_CLASSES = [OPEN_CLASS, 'slideOutLeft', 'fadeOutSidebarMask']
const OPENING_CLASS_ANIMATION = 'slideInLeft'
const CLOSED_CLASS = 'closed'
const CLOSED_CLASSES = [CLOSED_CLASS, 'slideInLeft', 'fadeInSidebarMask']
const CLOSING_CLASS_ANIMATION = 'slideOutLeft'

export default class extends ApplicationController {
  static values = { id: String }

  connect() {
    const { initSwipe, idValue, identifier } = this

    // If we are referencing a sidebar we do not need to create a sidebar
    if (idValue) return

    // this is so we can access the controller from anywhere in the dom
    // https://dev.to/leastbad/the-best-one-line-stimulus-power-move-2o90
    this.element[identifier] = this

    // This is the root css variable used for the breakpoint at which the
    // sidebar is open
    this.breakpoint = parseInt(
      window
        .getComputedStyle(document.documentElement)
        .getPropertyValue(SIDEBAR_BREAKPOINT)
        .trim()
        .replace(/[^0-9]/, ''),
      10,
    )

    initSwipe()
  }

  disconnect() {
    const { handleClickAway } = this

    this.destroySwipe()

    document.removeEventListener('click', handleClickAway, false)
  }

  destroySwipe() {
    if (!this.swipe) return

    this.swipe.destroy()
  }

  openSidebar() {
    const controller = document.querySelector(this.idValue)

    controller['sidebar-component--base'].handleOpen()
  }

  initSwipe = () => {
    this.destroySwipe()

    this.isOpen = !!this.element.classList.contains('open')

    if (this.isOpen) {
      document.addEventListener('click', this.handleClickAway, false)
    }

    const target = this.isOpen ? this.element : this.nextElementSibling

    this.swipe = new VanillaSwipe({
      element: document,
      target,
      onSwiped: this.handleSwipe,
      mouseTrackingEnabled: true,
      touchTrackingEnabled: true,
    })

    this.swipe.init()
  }

  handleClickAway = (event) => {
    const isClickInside = this.element.contains(event.target)

    if (isClickInside) {
      return
    }

    this.handleClose()
  }

  handleClose = () => {
    const { element, removeOpenClasses } = this

    const { classList } = element

    if (classList.contains('closed') || classList.contains(CLOSING_CLASS_ANIMATION)) {
      return
    }

    element.addEventListener('animationend', removeOpenClasses)
    classList.add('animated', CLOSING_CLASS_ANIMATION)

    element.nextElementSibling.classList.add('animated', 'fadeOutSidebarMask')
  }

  handleOpen = () => {
    const { element, removeClosedClasses } = this

    const { classList } = element

    if (classList.contains('open') || classList.contains(OPENING_CLASS_ANIMATION)) {
      return
    }

    element.addEventListener('animationend', removeClosedClasses)
    classList.add('animated', OPENING_CLASS_ANIMATION)

    element.nextElementSibling.classList.add('animated', 'fadeInSidebarMask')
  }

  handleSwipe = (_event, { directionX, velocity }) => {
    if (velocity <= 0.4 || document.body.clientWidth > this.breakpoint) {
      return
    }

    if (directionX === 'LEFT') {
      this.handleClose()
    } else {
      this.handleOpen()
    }
  }

  removeClasses = (...classes) => {
    this.element.classList.remove('animated', ...classes)
    this.element.nextElementSibling.classList.remove('animated', ...classes)
    this.initSwipe()
  }

  removeOpenClasses = () => {
    this.element.classList.add(CLOSED_CLASS)
    this.removeClasses(...OPEN_CLASSES)
    this.element.removeEventListener('animationend', this.removeOpenClasses)
    document.removeEventListener('click', this.handleClickAway, false)
  }

  removeClosedClasses = () => {
    this.element.classList.add(OPEN_CLASS)
    this.removeClasses(...CLOSED_CLASSES)
    this.element.removeEventListener('animationend', this.removeClosedClasses)
  }
}

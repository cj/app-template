import './base.scss'

import VanillaSwipe from 'vanilla-swipe'
import _ from 'lodash'
import ApplicationController from '~/controllers/application_controller'

const SIDEBAR_BREAKPOINT = '--bs-breakpoint-lg'
const OPPOSITE_DIRECTION = {
  left: 'right',
  up: 'down',
  right: 'left',
  down: 'up',
}

export default class extends ApplicationController {
  static values = { id: String }

  get animation() {
    if (!this.animationObject) {
      this.animationObject = JSON.parse(this.element.dataset.animation)
    }

    return this.animationObject
  }

  get openAnimationCss() {
    const { animation } = this

    return `${animation.type}Out${_.capitalize(animation.direction)}Sidebar`
  }

  get closeAnimationCss() {
    const { animation } = this

    return `${animation.type}In${_.capitalize(animation.direction)}Sidebar`
  }

  get isInViewport() {
    const rect = this.element.getBoundingClientRect()

    return (
      rect.top >= 0 &&
      rect.left >= 0 &&
      rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
      rect.right <= (window.innerWidth || document.documentElement.clientWidth) &&
      rect.width > 1
    )
  }

  get isOpen() {
    return !!this.element.classList.contains('open') || this.isInViewport
  }

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

  closeSidebar() {
    const controller = document.querySelector(this.idValue)

    controller['sidebar-component--base'].handleClose()
  }

  toggle() {
    const controller = document.querySelector(this.idValue)

    controller['sidebar-component--base'].handleToggle()
  }

  handleToggle() {
    const { element } = this
    const { classList } = element

    if (classList.contains('animated')) {
      return
    }

    element.addEventListener('animationend', this.animationEnd)

    classList.add('animated')

    if (this.isOpen) {
      classList.add(this.openAnimationCss)
      document.body.classList.remove('sidebar-open')
      document.body.classList.add('sidebar-closed')
      element.nextElementSibling.classList.add('animated', 'fadeOutSidebarMask')
    } else {
      classList.add(this.closeAnimationCss)
      document.body.classList.remove('sidebar-closed')
      document.body.classList.add('sidebar-open')
      element.nextElementSibling.classList.add('animated', 'fadeInSidebarMask')
    }
  }

  animationEnd = () => {
    const { element, animation } = this
    const { classList } = element

    classList.remove('animated')
    element.nextElementSibling.classList.remove('animated')

    if (this.isOpen) {
      classList.remove('open', this.openAnimationCss)
      classList.add('closed')

      element.nextElementSibling.classList.remove('fadeOutSidebarMask')

      document.removeEventListener('click', this.handleClickAway, false)
    } else {
      classList.remove('closed', this.closeAnimationCss)
      classList.add('open')

      element.nextElementSibling.classList.remove('fadeInSidebarMask')

      if (animation.type === 'float') {
        document.addEventListener('click', this.handleClickAway, false)
      }
    }

    this.initSwipe()

    element.removeEventListener('animationend', this.animationEnd)
  }

  initSwipe = () => {
    this.destroySwipe()

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

    this.handleToggle()
  }

  handleSwipe = (_event, { directionX, velocity }) => {
    if (
      velocity <= 0.4 ||
      (document.body.clientWidth > this.breakpoint && this.animation.type === 'float')
    ) {
      return
    }

    if (
      (this.isOpen && directionX === this.animation.direction.toUpperCase()) ||
      (!this.isOpen && directionX === OPPOSITE_DIRECTION[this.animation.direction].toUpperCase())
    ) {
      this.handleToggle()
    }
  }
}

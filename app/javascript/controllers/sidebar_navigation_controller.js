import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['sidebar']

   connect() {
    const path = this.getURLPath()
    const sidebarItem = this.sidebarTarget.querySelector('a[href*="' + path + '"]')
    const sidebarSection = sidebarItem.closest('.sidebar-section')

    sidebarItem.classList.add('active')
    sidebarSection.querySelector('a').classList.add('active')
    sidebarSection.querySelector('.sidebar-collapsable').classList.add('show')
  }

  getURLPath() {
    return '/' + String(document.location).split('/').slice(-1)
  }
}

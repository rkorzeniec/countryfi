import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['icon', 'source']

  copy() {
    const copyElement = document.createElement('input')
    this.prepareCopyElement(copyElement)
    this.selectCopyElement(copyElement)

    document.execCommand('copy')

    document.body.removeChild(copyElement)
    this.changeIconToCheck()

    setTimeout(() => this.changeIconToClipboard(), 1000)
  }

  prepareCopyElement(copyElement) {
    copyElement.value = this.data.get('url') + this.sourceTarget.value;

    copyElement.setAttribute('readonly', '')
    copyElement.style.position = 'absolute'
    copyElement.style.left = '-9999px'

    document.body.appendChild(copyElement)
  }

  selectCopyElement(copyElement) {
    copyElement.select()
    copyElement.setSelectionRange(0, 99999) /*For mobile devices*/
  }

  changeIconToCheck() {
    this.iconTarget.classList.remove('far')
    this.iconTarget.classList.remove('fa-clipboard')
    this.iconTarget.classList.add('fas')
    this.iconTarget.classList.add('fa-check')
  }

  changeIconToClipboard() {
    this.iconTarget.classList.remove('fas')
    this.iconTarget.classList.remove('fa-check')
    this.iconTarget.classList.add('far')
    this.iconTarget.classList.add('fa-clipboard')
  }
}

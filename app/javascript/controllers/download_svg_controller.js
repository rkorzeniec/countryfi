import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['svg', 'button', 'icon', 'spinner']

  connect() {
    import('save-svg-as-png').then(saveAsSvg => this.saveAsSvg = saveAsSvg.default)
  }

  download() {
    this.handlePreDownload()

    const postDownload = () => this.handlePostDownload()
    this.downloadSvg()
      .then(postDownload, postDownload)
  }

  downloadSvg() {
    return new Promise((resolve, reject) => {
      setTimeout(() => resolve(
        this.saveAsSvg.saveSvgAsPng(
          this.svgTarget,
          this.data.get('filename'),
          { scale: 2, encoderOptions: 1, backgroundColor: '#ffffff' }
        )
      ), 90)
    })
  }

  handlePreDownload() {
    this.buttonTarget.disabled = true
    this.iconTarget.classList.add('d-none')
    this.spinnerTarget.classList.remove('d-none')

    this.svgMapController.resize()
    this.svgMapController.map.disableControlIcons();
  }

  handlePostDownload() {
    this.spinnerTarget.classList.add('d-none')
    this.iconTarget.classList.remove('d-none')
    this.buttonTarget.disabled = false

    this.svgMapController.map.enableControlIcons();
  }

  get svgMapController() {
    return this.application.getControllerForElementAndIdentifier(
      this.element, 'svg-map'
    )
  }
}

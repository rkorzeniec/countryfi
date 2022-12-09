import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['items', 'pagination']

  scroll() {
    const nextPage = this.paginationTarget.querySelector("a[rel='next']")
    if (nextPage == null) { return }

    const height = this.calculateHeight()

    if (window.pageYOffset >= height - window.innerHeight) {
      this.loadMore(nextPage.href)
    }
  }

  calculateHeight() {
    const body = document.body
    const html = document.documentElement
    const paginationBuffer = 10

    const height = Math.max(
      body.scrollHeight, body.offsetHeight, html.clientHeight, html.scrollHeight,
      html.offsetHeight
    )

    return height - paginationBuffer
  }

  loadMore(url) {
    const options = {
      method: 'GET',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json;charset=utf-8'
      }
    }
    this.paginationTarget.innerText = 'Please wait...'

    fetch(url, options)
      .then(response => response.json())
      .then(data => {
        this.itemsTarget.insertAdjacentHTML('beforeend', data.items)

        const paginationHTML = data.next_page === null ? "" : data.pagination
        this.paginationTarget.innerHTML = paginationHTML
      })
  }
}

import { Controller } from '@hotwired/stimulus'
import { getBoundingBox } from '../src/utils/bounding_box'

export default class extends Controller {
  static targets = ['element']

  connect() {
    import('mapbox-gl').then(mapbox => {
      this.mapbox = mapbox.default
      this.map = null
      this.initMapbox()
    })
  }

  initMapbox() {
    if (!this.elementTarget) { return }

    this.mapbox.accessToken = this.data.get('api-key')

    this.map = new this.mapbox.Map(this.mapboxOptions())
    this.map.addControl(this.navigationControl())
    this.map.on('load', () => this.applyCountryLayer())
  }

  mapboxOptions() {
    return {
      container: 'mapbox',
      style: 'mapbox://styles/mapbox/streets-v10',
      center: [this.data.get('lng'), this.data.get('lat')],
      zoom: 4
    }
  }

  navigationControl() {
    return new this.mapbox.NavigationControl({position: 'bottom-right'})
  }

  applyCountryLayer() {
    const geojson = JSON.parse(this.data.get('geojson'))
    const boundingBox = getBoundingBox(geojson)

    this.map.addSource(this.data.get('cca3'), {
      'type': 'geojson',
      'data': geojson
    })

    this.map.addLayer({
      'id': 'route',
      'type': 'fill',
      'source': this.data.get('cca3'),
      'layout': {},
      'paint': {
        'fill-color': '#088',
        'fill-opacity': 0.8
      }
    })

    this.map.fitBounds(boundingBox, { padding: 20 })
  }
}

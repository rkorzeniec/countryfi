import { Controller } from 'stimulus'
import mapboxgl from 'mapbox-gl'

export default class extends Controller {
  static targets = ['element']

  connect() {
    this.map = null
    this.initMapbox()
  }

  initMapbox() {
    if (!this.elementTarget) { return }

    mapboxgl.accessToken = this.data.get('api-key')

    this.map = new mapboxgl.Map(this.mapboxOptions())
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
    return new mapboxgl.NavigationControl({position: 'bottom-right'})
  }

  applyCountryLayer() {
    const geojson = JSON.parse(this.data.get('geojson'))
    const boundingBox = this.getBoundingBox(geojson)

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

  getBoundingBox(geojson) {
    const geometryType = geojson.features[0].geometry.type

    if (geometryType === 'MultiPolygon') {
      return this.getMultiPolygonBounds(geojson.features[0].geometry.coordinates)
    }
    else {
      return this.getPolygonBounds(geojson.features[0].geometry.coordinates)
    }
  }

  getMultiPolygonBounds(coordinates) {
    const southWest = coordinates[0][0][0]
    const northEast = coordinates[coordinates.length - 1][0][0]

    return [southWest, northEast]
  }

  getPolygonBounds(coordinates) {
    const southWest = coordinates[0][0]
    const northEast = coordinates[0][coordinates[0].length - 1]

    console.log(coordinates[0])
    // console.log(southWest)
    // console.log(northEast)

    return [southWest, northEast]
  }
}

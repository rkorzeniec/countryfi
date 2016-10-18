window.PixelAdmin.init.push(function () {
  mapboxgl.accessToken = 'pk.eyJ1IjoidHJlYm9yIiwiYSI6ImNpdHg0a24xczAwMzgydG4yemF6YXkzY2MifQ.H8nqDel1PDvxl07Bm7a0DQ';
  var map = new mapboxgl.Map({
      container: 'map', // container id
      style: 'mapbox://styles/trebor/citx4nquk009d2iqiqplpua02', //stylesheet location
      center: [-74.50, 40], // starting position
      zoom: 9 // starting zoom
  });

  map.featureLayer.on('ready', function(e) {
    getCountry(map);
  });
});

function getCountry(map) {
  var $loading_wheel = $("#spinning-wheel")
  $loading_wheel.show();
  $.ajax({
    dataType: 'text',
    url: '/country.json',
    success:function(events) {
      $loading_wheel.hide();
      var geojson = $.parseJSON(events);
      map.featureLayer.setGeoJSON({
        type: "FeatureCollection",
        features: geojson
      });
      addEventPopups(map);
    },
    error:function() {
      $loading_wheel.hide();
      alert("Could not load the events");
    }
  });
}

function addEventPopups(map) {
  map.featureLayer.on("layeradd", function(e){
    var marker = e.layer;
    var properties = marker.feature.properties;
    var popupContent = '<div class="marker-popup">' + '<h3>' + properties.title + '</h3>' +
                       '<h4>' + properties.address + '</h4>' + '</div>';
    marker.bindPopup(popupContent, {closeButton: false, minWidth: 300});
  });
}

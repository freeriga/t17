var tileUrl = "https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png"
var map = L.map("banner-map", {
  zoomControl: false,
  scrollWheelZoom: false,
  attributionControl: false
})

L.tileLayer(tileUrl , {
  attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a>'
}).addTo(map)

map.addControl(L.control.attribution({
  position: "bottomright",
  prefix: ""
}))

var root = document.querySelector("#banner-map")
var coords = root.getAttribute("data-coords").split(", ")

map.setView(coords, 16)

var icon = L.divIcon({
  className: "map-icon",
  html: document.querySelector("#index").innerText,
  iconSize: [50, 50]
})
var marker = L.marker(coords, { icon: icon }).addTo(map)

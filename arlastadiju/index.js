var places = {}
var currentPlace

function array(x) { return [].slice.call(x) }
function queryAll(x, selector) { return array(x.querySelectorAll(selector)) }
function query(x, selector) { return x.querySelector(selector) }

function debounce (func, wait, immediate) {
  var timeout
  return function () {
    var context = this, args = arguments
    var later = function () {
      timeout = null
      if (!immediate) func.apply(context, args)
    };
    var callNow = immediate && !timeout
    clearTimeout(timeout)
    timeout = setTimeout(later, wait)
    if (callNow) func.apply(context, args)
  }
}

var showPopup = function (place) {
  place.marker.openPopup()
  // map.setView(place.coords, 16)
  // window.open(location.href + "#stasts" + (i + 1), "_blank")
}

onload = function () {
  var t17Coords = [56.943148, 24.123707]

  var map = L.map("mapelement", {
    zoomControl: false,
    scrollWheelZoom: false,
    attributionControl: false
  })

  L.tileLayer(
  // "http://{s}.tile.osm.org/{z}/{x}/{y}.png"
   "https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png"

//    "http://a.tile.stamen.com/toner-lite/{z}/{x}/{y}.png"
  , { attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a>' }
  ).addTo(map)

  map.addControl(L.control.attribution({
    position: "bottomright",
    prefix: ""
  }))

  var aside = query(document, "aside")

  var allMarkers = []

  // Collect data about places from HTML
  queryAll(document, "article").forEach(function (x, i) {
    x.id = "vieta" + (i + 1)

    var place = {
      name: query(x, "h3 .name").innerText,
      coords: query(x, "coords").innerText.split(", "),
      description: query(x, "p.summary").innerText,
      story: array(
        queryAll(x, "p:not(.summary)")
      ).map(
        function (x) { return x.outerHTML }
      ).join("\n")
    }

    console.log(place.name, place.coords)

    places[i + 1] = place
  })

  if (location.hash.match(/stasts(\d+)$/)) {
    var i = RegExp.$1
    currentPlace = places[i]
    query(document, "h1").innerHTML = currentPlace.name
    query(document, "h2").innerHTML = "Tikšanās ar Lastādiju"
    aside.innerHTML = currentPlace.story
    aside.className = "visible"
    document.body.className = "story"
    document.title = currentPlace.name
    map.setView(currentPlace.coords, 16)
  } else {
    aside.className = ""
    document.body.className = ""
  }

  var hoverTimeout

  queryAll(document, "article").forEach(function (x, i) {
    var place = places[i + 1]

    function popup(coords, title, text, i) {
      var icon = L.divIcon({
        className: (
          "map-icon " + ((currentPlace && (places[i] != currentPlace)) ? "dim" : "")
        ),
        html: i
      })
      place.marker = L.marker(coords, { icon: icon }).addTo(map)
      allMarkers.push(place.marker)
      if (!currentPlace) {
        place.marker.bindPopup(
          "<b>" + title + "</b><p>" + text +
          "</p><a target=_blank href=#stasts" + i + ">Lasīt vairāk</a>", {
            maxWidth: 400,
            offset: L.point(7, 4)
          }
        ).bindTooltip(title)
      }
    }

    if (place.coords.length == 2) {
      popup(place.coords, place.name, place.description, i + 1)
    }

    x.onmouseenter = function () {
      hoverTimeout = setTimeout(function () {
        showPopup(place)
      }, 500)
      console.log("setting timeout", place.name, hoverTimeout)
      return false;
    }

    x.onmouseleave = function () {
      console.log("clearing timeout", hoverTimeout)
      clearTimeout(hoverTimeout)
    }

    x.onclick = function () {
      window.open(location.href + "#stasts" + (i + 1), "_blank")
      return false
    }
  })

  if (!currentPlace)
    map.fitBounds(L.featureGroup(allMarkers).getBounds())
}

var map
var places
var allMarkers = []
var hoverTimeout

map = L.map("mapelement", {
  zoomControl: true,
  scrollWheelZoom: false,
  attributionControl: false
})

// Use Wikimedia's OpenStreetMap tile rendering
L.tileLayer("https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png", {
  attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a>'
}).addTo(map)

// Show the copyright attribution
map.addControl(L.control.attribution({
  position: "bottomright",
  prefix: ""
}))

// Collect data about places from HTML
places = queryAll(document, "li.place").map(
  function parsePlaceElement (x, i) {
    var nameElement = query(x, "h3 .name")
    return {
      index: i,
      element: x,
      name: nameElement.innerText,
      nameElement: nameElement,
      coords: x.getAttribute("data-coords").split(", "),
      snippet: query(x, "p.summary").innerText,
      story: x.getAttribute("data-has-story") == "true",
      id: x.getAttribute("data-id")
    }
  }
)

// Set up map markers and popups
queryAll(document, "li.place").forEach(function (x, i) {
  var place = places[i]

  function popup(coords, title, text, i) {
    var icon = L.divIcon({ className: "map-icon",  html: (i + 1) })
    place.marker = L.marker(coords, { icon: icon }).addTo(map)
    setupMarkerFading(place)
    setupMarkerPopup(place)
    allMarkers.push(place.marker)
  }

  popup(place.coords, place.name, place.snippet, i)

  x.onmouseenter = function () {
    place.nameElement.className = "name pulse"
    places.forEach(function (x) {
      toggleClass(x.marker._icon, "shade", true)
    })
    toggleClass(place.marker._icon, "shade", false)
    hoverTimeout = setTimeout(function () {
      place.marker.openPopup()
      map.panTo(place.coords, 17)
    }, 500)
    return false;
  }

  x.onmouseleave = function () {
    places.forEach(function (x) {
      toggleClass(x.marker._icon, "shade", false)
    })
    queryAll(document, "li.place .name").forEach(function (x) {
      x.className = "name"
    })
    clearTimeout(hoverTimeout)
  }
})

map.fitBounds(L.featureGroup(allMarkers).getBounds())
map.on("popupclose", function () {
  map.fitBounds(L.featureGroup(allMarkers).getBounds())
})

// DOM utility functions
function array(x) { return [].slice.call(x) }
function queryAll(x, selector) { return array(x.querySelectorAll(selector)) }
function query(x, selector) { return x.querySelector(selector) }

function toggleClass(x, klass, on) {
  var classes = x.className.split(" ")
  var i = classes.indexOf(klass)
  if (on && i == -1) {
    classes.push(klass)
  } else if (!on && i >= 0) {
    classes.splice(i, 1)
  }
  x.className = classes.join(" ")
}

function setupMarkerFading(place) {
  // Immediate timeout needed because the _icon member is not
  // initialized yet.
  setTimeout(function () {
    var icon = place.marker._icon
    
    icon.onmouseenter = icon.onfocus = function () {
      places.forEach(function (x) {
        if (x.index != place.index) {
          toggleClass(x.element, "shade", true)
          toggleClass(x.marker._icon, "shade", true)
        }
      })
    }
    
    icon.onmouseleave = icon.onblur = function () {
      places.forEach(function (x) {
        toggleClass(x.element, "shade", false)
        toggleClass(x.marker._icon, "shade", false)
      })
    }
  })
}

function setupMarkerPopup(place) {
  var readMoreLink = place.story
      ? "<a target=_blank href=" + place.id + ".html>Lasīt vairāk</a>"
      : ""
  place.marker.bindPopup(
    "<b>" + place.name + "</b><p>" + place.snippet + "</p>" + readMoreLink, {
      maxWidth: 400,
      offset: L.point(7, 4),
      autoPanPadding: L.point(10, 10)
    }
  )
}

function showTheMap() {
  query(document, "aside").className += " hidden"
}
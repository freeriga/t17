var map
var places
var allMarkers = []
var highlightTimeout
var unhighlightTimeout
var storyListElement = document.querySelector("ul.stories")
var mapElement = document.querySelector("#mapelement")

map = L.map("mapelement", {
  zoomControl: true,
  scrollWheelZoom: false,
  attributionControl: false,
  zoomControl: false
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

map.addControl(L.control.zoom({
  position: "topright"
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
      snippet: query(x, ".summary").innerText,
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
    highlightPlace(place, false, true)
    return false;
  }

  x.onmouseleave = function () {
    unhighlightPlace(place, true)
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

function highlightPlace(place, doScroll, doPan) {
  clearTimeout(highlightTimeout)
  clearTimeout(unhighlightTimeout)
  toggleClass(storyListElement, "shade", true)
  toggleClass(mapElement, "shade", true)
  toggleClass(place.element, "highlight", true)
  toggleClass(place.marker._icon, "highlight", true)
  highlightTimeout = setTimeout(function () {
    if (doScroll)
      scrollIntoView(place.nameElement, storyListElement)
    if (doPan)
      map.panTo([+place.coords[0], place.coords[1]], 17)
  }, 500)
}

function unhighlightPlace(place, doFit) {
  clearTimeout(highlightTimeout)
  clearTimeout(unhighlightTimeout)
  toggleClass(storyListElement, "shade", false)
  toggleClass(mapElement, "shade", false)
  toggleClass(place.element, "highlight", false)
  toggleClass(place.marker._icon, "highlight", false)
  unhighlightTimeout = setTimeout(function () {
    if (doFit)
      map.fitBounds(L.featureGroup(allMarkers).getBounds())
  }, 500)
}

function setupMarkerFading(place) {
  // Immediate timeout needed because the _icon member is not
  // initialized yet.
  setTimeout(function () {
    var icon = place.marker._icon
    
    icon.onmouseenter = icon.onfocus = function () {
      highlightPlace(place, true, false)
      // places.forEach(function (x) {
      //   if (x.index != place.index) {
      //     toggleClass(x.element, "shade", true)
      //     toggleClass(x.marker._icon, "shade", true)
      //   }
      // })
    }
    
    icon.onmouseleave = icon.onblur = function () {
      unhighlightPlace(place)
      // places.forEach(function (x) {
      //   toggleClass(x.element, "shade", false)
      //   toggleClass(x.marker._icon, "shade", false)
      // })
    }
  })
}

function setupMarkerPopup(place) {
  if (place.story) {
    setTimeout(function () {
      place.marker._icon.className += " link"
      place.marker._icon.onclick = function () {
        window.open("stasts/" + place.id, place.id)
      }
    })
  }
}

function showTheMap() {
  query(document, "aside").className += " hidden"
}

function scrollIntoView(needle, haystack) {
  var xTop = needle.offsetTop
  var xBottom = xTop + needle.clientHeight
  var yTop = haystack.scrollTop
  var yBottom = yTop + haystack.clientHeight
  console.log(xTop, xBottom, yTop, yBottom)
  // needle.scrollIntoView({ behavior: "smooth" })
//  if (xTop < yTop || xBottom > yBottom) {
    scrollTarget = xTop + needle.clientHeight / 2.0
    smoothScroll(
      storyListElement, 0,
      scrollTarget - storyListElement.clientHeight / 2 + 50
    )
//    ensureScrollAnimation()
//  }
}

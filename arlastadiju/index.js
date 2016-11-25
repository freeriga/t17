var tileUrl = "https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png"

var places = {}
var currentPlace
var allMarkers = []

function array(x) { return [].slice.call(x) }
function queryAll(x, selector) { return array(x.querySelectorAll(selector)) }
function query(x, selector) { return x.querySelector(selector) }

onload = function () {
  var t17Coords = [56.943148, 24.123707]

  var map = L.map("mapelement", {
    zoomControl: true,
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

  var aside = query(document, "aside")

  // Collect data about places from HTML
  queryAll(document, "article").forEach(function (x, i) {
    x.id = "vieta" + (i + 1)

    var nameElement = query(x, "h3 .name")

    var place = {
      name: nameElement.innerText,
      nameElement: nameElement,
      coords: query(x, "coords").innerText.split(", "),
      description: query(x, "p.summary").innerText,
      story: array(
        queryAll(x, "p:not(.summary)")
      ).map(
        function (x) { return x.outerHTML }
      ).join("\n")
    }

    places[i + 1] = place
  })

  if (location.hash.match(/stasts(\d+)$/)) {
    var i = RegExp.$1
    currentPlace = places[i]
    query(document, "h1").innerHTML = currentPlace.name
    query(document, "h2").innerHTML = "" // "Tikšanās ar Lastādiju"
    aside.innerHTML = currentPlace.story
    document.body.className = "story"
    document.title = currentPlace.name
    map.setView(currentPlace.coords, 16)
  } else {
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
      setTimeout(function () {
        place.marker._icon.onmouseenter = place.marker._icon.onfocus = function() {
          queryAll(document, "article").forEach(function (article, j) {
            if (i != j + 1) {
              article.className += " shade"
              places[j + 1].marker._icon.className += " shade"
            }

            // if (places[j + 1].marker._icon == document.activeElement)
            //   places[j + 1].marker.openPopup()
          })
        }
        place.marker._icon.onmouseleave = place.marker._icon.onblur = function () {
          queryAll(document, "article").forEach(function (article, j) {
            article.className = article.className.replace(" shade", "")
            places[j + 1].marker._icon.className =
              places[j + 1].marker._icon.className.replace(" shade", "")
          })
        }
      })
      allMarkers.push(place.marker)
      if (!currentPlace) {
        place.marker.bindPopup(
          "<b>" + title + "</b><p>" + text +
          "</p><a target=_blank href=#stasts" + i + ">Lasīt vairāk</a>", {
            maxWidth: 400,
            offset: L.point(7, 4),
            autoPanPadding: L.point(20, 20)
          }
        )
      }
    }

    if (place.coords.length == 2) {
      popup(place.coords, place.name, place.description, i + 1)
    }

    x.onmouseenter = function () {
      place.nameElement.className = "name pulse"
      Object.keys(places).forEach(function (x) {
        var marker = places[x].marker
        if (marker)
          marker._icon.className += " shade"
      })
      place.marker._icon.className =
        place.marker._icon.className.replace(" shade", "")
      hoverTimeout = setTimeout(function () {
        place.marker.openPopup()
      }, 500)
      return false;
    }

    x.onmouseleave = function () {
      Object.keys(places).forEach(function (x) {
        var marker = places[x].marker
        if (marker)
          marker._icon.className =
            marker._icon.className.replace(" shade", "")
      })
      queryAll(document, "article .name").forEach(function (x) {
        x.className = "name"
      })
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

var form = document.querySelector("form")
var required = ["place-name", "address", "short-story", "contact", "contact-name"]
form.onsubmit = function () {
  var missing = []
  required.forEach(function (field) {
    if (form[field].value.match(/^\s*$/)) {
      missing.push(form[field].labels[0].innerText)
      form[field].className += " missing"
    }
  })
  if (missing.length > 0) {
    alert("Lūdzu, aizpildiet trūkstošos lauciņus!")
    return false
  }
}
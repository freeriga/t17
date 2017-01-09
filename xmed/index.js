let tag = React.createElement
let component = React.createClass

let state = {
  document: null
}

let array = x => [].slice.apply(x)

let Editor = component({
  render: function () {
    return this.props.document
      ? tag(
        "ol", {}, array(this.props.document.childNodes).map(renderNode)
      ) : "Loading..."
  }
})

let filterNodes = xs => array(xs).filter(
  x => x.nodeType != Node.TEXT_NODE || x.textContent.match(/\S/)
)

let renderNode = x => tag(
  "li", {}, ...(
    x.nodeType == Node.TEXT_NODE ? (
      x.textContent.match(/\S/) ? (
        [tag("p", {}, [x.textContent])]
      ) : []
    ) : [
      tag(
        "span", { className: "tag-name" }, [x.tagName]
      ), ...(
        filterNodes(x.childNodes).length
          ? [tag("ol", {}, filterNodes(x.childNodes).map(renderNode))] : []
      )
    ]
  )
)

let main = document.querySelector("main")

let change = patch => {
  state = Object.assign({}, state, patch)
  ReactDOM.render(tag(Editor, state), main)
}

let load = text => change({
  document: (new DOMParser).parseFromString(text, "application/xml")
})

fetch("example.xml").then(x => x.text()).then(load)

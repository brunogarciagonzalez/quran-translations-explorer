document.addEventListener("DOMContentLoaded", init);

function init() {
  // make a simple form that sends query on click
  let form = document.createElement("form");
  let input = document.createElement("input");
  let button = document.createElement("input");
  input.placeholder = "Allahu Ackbar!";
  input.name = "term";
  button.type = "submit";
  button.innerHTML = "Search!";
  form.appendChild(input);
  form.appendChild(button);
  let root = document.getElementById("root");
  root.appendChild(form);
  form.addEventListener("submit", toBackend);
  // display results
}

function toBackend(event) {
  event.preventDefault();
  let term = event.target.elements.namedItem("term").value;

  fetch("http://localhost:3000/query", {
    method: "POST",
    headers: { "Content-Type": "application/json", Accept: "application/json" },
    body: JSON.stringify({ query: { term: term, language: "english" } })
  })
    .then(r => r.json())
    .then(json => {
      debugger;
      console.log(json);
    });
}

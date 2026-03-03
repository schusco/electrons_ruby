import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  connect() {
    this.sortable = Sortable.create(this.element, {
      onEnd: this.end.bind(this)
    })
  }

  end(event) {
    const rows = this.element.querySelectorAll("tr")
  
    rows.forEach((row, index) => {
        // Find the rank field inside this specific row
        const rankInput = row.querySelector(".rank-input")
        if (rankInput) {
        // index starts at 0, so we use index + 1 for Rank 1, 2, 3...
        rankInput.value = index + 1
        console.log(`Updated Row ID ${row.dataset.id} to Rank ${index + 1}`)
        }
    })
    fetch(this.element.closest("form").action, {
      method: "PATCH",
      body: new FormData(this.element.closest("form")),
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        "Accept": "application/json"
      }
    })
    .then(response => {
      if (response.ok) { console.log("Saved!") }
    })    
  }  
}
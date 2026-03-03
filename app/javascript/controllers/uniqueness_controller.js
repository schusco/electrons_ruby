import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "error"]
  static values = { category: String }

  async check() {
    const year = this.inputTarget.value
    if (!year) return

    const response = await fetch(`/histories/check_uniqueness?year=${year}&category=${this.categoryValue}`)
    const data = await response.json()

    if (!data.available) {
      this.errorTarget.textContent = "This year already exists!"
      this.inputTarget.classList.add("is-invalid")
      this.inputTarget.style.borderColor = "red"
      console.log("Year not available:", data.message)
    } else {
      this.errorTarget.textContent = ""
      this.errorTarget.style.display = "none"
      this.inputTarget.classList.remove("is-invalid")
      this.inputTarget.style.borderColor = ""
      console.log("Year is available")
    }
  }
}
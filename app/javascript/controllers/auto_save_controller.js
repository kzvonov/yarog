import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["textarea", "status"]
  static values = { url: String }

  connect() {
    this.timeout = null
    this.saving = false
  }

  scheduleSave() {
    // Clear any existing timeout
    if (this.timeout) {
      clearTimeout(this.timeout)
    }

    // Show "typing..." status
    this.updateStatus("typing...")

    // Set new timeout for 3 seconds
    this.timeout = setTimeout(() => {
      this.save()
    }, 3000)
  }

  async save() {
    if (this.saving) return

    this.saving = true
    this.updateStatus("saving...")

    try {
      const response = await fetch(this.urlValue, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": this.csrfToken
        },
        body: JSON.stringify({
          notes: this.textareaTarget.value
        })
      })

      if (response.ok) {
        this.updateStatus("saved ✓")
        setTimeout(() => {
          this.updateStatus("")
        }, 2000)
      } else {
        this.updateStatus("error ✗")
      }
    } catch (error) {
      console.error("Auto-save failed:", error)
      this.updateStatus("error ✗")
    } finally {
      this.saving = false
    }
  }

  updateStatus(message) {
    if (this.hasStatusTarget) {
      this.statusTarget.textContent = message
    }
  }

  get csrfToken() {
    return document.querySelector("[name='csrf-token']").content
  }
}

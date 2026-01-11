import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]

  connect() {
    // Restore collapsed state from localStorage on page load
    this.contentTargets.forEach(content => {
      const section = content.dataset.section
      const isOpen = this.getSectionState(section)

      if (isOpen) {
        content.classList.remove("hidden")
        this.updateButtonIcon(content, true)
      } else {
        content.classList.add("hidden")
        this.updateButtonIcon(content, false)
      }
    })
  }

  toggle(event) {
    const button = event.currentTarget
    const section = button.dataset.collapsibleSection
    const content = this.contentTargets.find(el => el.dataset.section === section)

    if (!content) return

    const isCurrentlyOpen = !content.classList.contains("hidden")

    if (isCurrentlyOpen) {
      content.classList.add("hidden")
      this.updateButtonIcon(content, false)
      this.saveSectionState(section, false)
    } else {
      content.classList.remove("hidden")
      this.updateButtonIcon(content, true)
      this.saveSectionState(section, true)
    }
  }

  updateButtonIcon(content, isOpen) {
    const section = content.dataset.section
    const button = this.element.querySelector(`[data-collapsible-section="${section}"]`)

    if (button) {
      const icon = isOpen ? "▼" : "▶"
      const text = button.querySelector("span").textContent
      const label = text.substring(2) // Remove current icon
      button.querySelector("span").textContent = `${icon} ${label}`
    }
  }

  getSectionState(section) {
    const state = localStorage.getItem(`collapsible_${section}`)
    // Default to open for "basics" sections, closed for others
    if (state === null) {
      return section.startsWith("basics")
    }
    return state === "true"
  }

  saveSectionState(section, isOpen) {
    localStorage.setItem(`collapsible_${section}`, isOpen.toString())
  }
}

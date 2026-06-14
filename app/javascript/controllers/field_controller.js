import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  focus(event) {
    if (
      event.target.closest(
        "input, textarea, select, button, a"
      )
    ) return;

    this.inputTarget.focus()
    const end = this.inputTarget.value.length;
    this.inputTarget.setSelectionRange(end, end);
  }
}
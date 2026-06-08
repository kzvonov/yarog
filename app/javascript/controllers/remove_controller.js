import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // TODO: make it disappear gradually
    setTimeout(() => {
      this.element.remove()
    }, 3000);
  }

  run() {
    this.element.remove();
  }
}
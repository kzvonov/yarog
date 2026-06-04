import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "panel", "textarea"];

  static values = {
    key: String
  };

  connect() {
    const saved = localStorage.getItem(this.storageKey);
    this.activate(saved || this.tabTargets[0].dataset.tab);

    this.textareaTargets.forEach(textarea => { this.updateCount(textarea) });
  }

  show(event) {
    const selectdTabName = event.currentTarget.dataset.tab;
    this.activate(selectdTabName);
  }

  onInput(event) {
    this.updateCount(event.currentTarget);
  }

  updateCount(textarea) {
    const count = textarea.value
      .split("\n")
      .filter(line => line.trim())
      .length
    const tabName = textarea.dataset.tab;
    const tab = this.tabTargets.find(tab => tab.dataset.tab === tabName);
    if (!tab) return;

    tab.querySelector("span.tab-count").textContent = count
  }

  activate(tabName) {
    this.tabTargets.forEach(tab => {
      tab.classList.toggle("tab--active", tab.dataset.tab == tabName)
    });

    this.panelTargets.forEach(panel => {
      panel.hidden = panel.dataset.panel != tabName;
    });

    localStorage.setItem(this.storageKey, tabName);
  }



  get storageKey() {
    return `tabs:${this.keyValue}`
  }
};
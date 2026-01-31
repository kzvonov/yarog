// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

function initCopyHandlers() {
  document.querySelectorAll('.copy-handler').forEach(element => {
    element.addEventListener('click', function () {
      console.log(this.dataset.copyValue)
      const textToCopy = this.dataset.copyValue;
      const originalContent = this.innerHTML;

      if (!textToCopy) return;

      navigator.clipboard.writeText(textToCopy).then(() => {
        this.innerHTML = 'Copied...';
        setTimeout(() => {
          this.innerHTML = originalContent;
        }, 200);
      }).catch(err => {
        console.error('Failed to copy:', err);
      });
    });
  });
}

document.addEventListener('DOMContentLoaded', initCopyHandlers);
document.addEventListener('turbo:load', initCopyHandlers);
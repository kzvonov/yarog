/**
 * Hero Module
 * Simple module for rendering hero data and collecting it back
 */

const Hero = (function () {
  'use strict';

  function setValue(element, value) {
    if (element instanceof HTMLInputElement) {
      if (element.type === 'checkbox' || element.type === 'radio') {
        element.checked = Boolean(value);
      } else {
        element.value = value ?? '';
      }
    }
    else if (element instanceof HTMLTextAreaElement ||
      element instanceof HTMLSelectElement) {
      element.value = value ?? '';
    }
    else {
      element.textContent = value ?? '';
    }
  }

  function getValue(element) {
    if (element instanceof HTMLInputElement) {
      if (element.type === 'checkbox' || element.type === 'radio') {
        return element.checked;
      }
      return element.value;
    }
    if (element instanceof HTMLTextAreaElement ||
      element instanceof HTMLSelectElement) {
      return element.value;
    }
    return element.textContent;
  }

  function updateModifierColors() {
    document.querySelectorAll('.dice_modifier').forEach(el => {
      const value = parseInt(el.textContent);
      if (value < 0) {
        el.style.color = 'var(--accent-blood)';
      } else if (value > 0) {
        el.style.color = 'var(--accent-green)';
      } else {
        el.style.color = '';
      }
    });
  }

  function hasChanged(value, currentValue) {
    if (typeof value == 'undefined') {
      return false;
    }

    if ([null, false].includes(value) && [null, false].includes(currentValue)) {
      return false;
    }

    return String(value) !== String(currentValue);
  }

  function renderArray(container, arrayData, arrayName, attrName) {
    const template = container.querySelector('template');
    if (!template) return;

    // Remove all children except template
    container.querySelectorAll(':scope > :not(template)').forEach(el => el.remove());

    // Render each array item
    (arrayData || []).forEach((item, index) => {
      const clone = template.content.cloneNode(true);

      // Find all elements with data attribute and replace [] with [index]
      clone.querySelectorAll(`[${attrName}]`).forEach(el => {
        const id = el.getAttribute(attrName);
        if (id.includes('[]')) {
          const newId = id.replace('[]', `[${index}]`);
          el.setAttribute(attrName, newId);

          // Extract field name (e.g., "moves[0].name" -> "name")
          const field = id.split('.').pop();
          setValue(el, item[field]);
        }
      });

      container.appendChild(clone);
    });
  }

  function render(heroData = {}) {
    // Render both data-sync-id and data-render-id elements
    const syncElements = document.querySelectorAll('[data-sync-id]');
    const renderElements = document.querySelectorAll('[data-render-id]');

    // Render data-sync-id elements (editable)
    syncElements.forEach(el => {
      const key = el.dataset.syncId;
      const value = heroData[key];

      // Check if this is an array container
      if (Array.isArray(value)) {
        renderArray(el, value, key, 'data-sync-id');
        return;
      }

      const currentValue = getValue(el);

      if (hasChanged(value, currentValue)) {
        setValue(el, value);

        el.classList.add('value-updated');
        setTimeout(() => el.classList.remove('value-updated'), 200);
      }
    });

    // Render data-render-id elements (read-only)
    renderElements.forEach(el => {
      const key = el.dataset.renderId;
      const value = heroData[key];

      // Check if this is an array container
      if (Array.isArray(value)) {
        renderArray(el, value, key, 'data-render-id');
        return;
      }

      const currentValue = getValue(el);

      if (hasChanged(value, currentValue)) {
        setValue(el, value);

        el.classList.add('value-updated');
        setTimeout(() => el.classList.remove('value-updated'), 200);
      }
    });

    updateModifierColors();
  }

  function getData() {
    const result = {};
    const elements = document.querySelectorAll('[data-sync-id]');

    elements.forEach(el => {
      const syncId = el.dataset.syncId;
      if (!syncId) return;

      // Check if this is an array element (e.g., "moves[0].name")
      const arrayMatch = syncId.match(/^(\w+)\[(\d+)\]\.(\w+)$/);
      if (arrayMatch) {
        const [, arrayName, index, field] = arrayMatch;
        const idx = parseInt(index);

        // Initialize array if needed
        if (!result[arrayName]) {
          result[arrayName] = [];
        }

        // Initialize object at index if needed
        if (!result[arrayName][idx]) {
          result[arrayName][idx] = {};
        }

        // Set field value
        result[arrayName][idx][field] = getValue(el);
      } else if (el.querySelector('template')) {
        // Skip array containers (they have a template inside)
        // Arrays are collected via their indexed children above
        result[syncId] = [];
      } else {
        // Regular field
        result[syncId] = getValue(el);
      }
    });

    return result;
  }
  return {
    render,
    getData,
    helpers: {
      setValue,
      getValue
    }
  };
})();

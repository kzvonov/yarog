import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "status", "nameInput", "movesList",
    "equipmentCount", "conditionCount", "notesCount"
  ]
  static values = {
    url: String
  }

  connect() {
    this.timeout = null
    this.csrfToken = document.querySelector('meta[name="csrf-token"]')?.content
  }

  scheduleUpdate(event) {
    if (this.timeout) clearTimeout(this.timeout)

    this.updateStatus("typing...")

    // Update character counts if applicable
    const field = event.target.dataset.field
    if (field === 'equipment' && this.hasEquipmentCountTarget) {
      this.equipmentCountTarget.textContent = event.target.value.length
    } else if (field === 'condition' && this.hasConditionCountTarget) {
      this.conditionCountTarget.textContent = event.target.value.length
    } else if (field === 'notes' && this.hasNotesCountTarget) {
      this.notesCountTarget.textContent = event.target.value.length
    }

    // Update stat modifiers in real-time
    if (field && field.startsWith('stat_')) {
      const stat = field.replace('stat_', '')
      const value = parseInt(event.target.value) || 10
      const modifier = this.calculateModifier(value)
      const modifierEl = this.element.querySelector(`[data-hero-editor-target="modifier_${stat}"]`)
      if (modifierEl) {
        modifierEl.textContent = modifier >= 0 ? `+${modifier}` : `${modifier}`
      }
    }

    this.timeout = setTimeout(() => {
      this.save()
    }, 3000)
  }

  calculateModifier(statValue) {
    // Dungeon World modifier tiers
    if (statValue <= 3) return -3
    if (statValue <= 5) return -2
    if (statValue <= 8) return -1
    if (statValue <= 12) return 0
    if (statValue <= 15) return 1
    if (statValue <= 17) return 2
    return 3
  }

  saveNow() {
    if (this.timeout) {
      clearTimeout(this.timeout)
    }
    this.save()
  }

  async save() {
    this.updateStatus("saving...")

    const heroData = this.collectHeroData()

    try {
      const response = await fetch(this.urlValue, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": this.csrfToken
        },
        body: JSON.stringify({ hero: heroData })
      })

      if (response.ok) {
        this.updateStatus("saved", true)
      } else {
        this.updateStatus("error saving", false)
      }
    } catch (error) {
      this.updateStatus("error saving", false)
      console.error("Save error:", error)
    }
  }

  collectHeroData() {
    const data = {
      hero_data: {
        stats: {},
        debilities: {},
        moves: []
      }
    }

    // Collect all fields
    this.element.querySelectorAll('[data-field]').forEach(field => {
      const fieldName = field.dataset.field
      let value

      if (field.type === 'checkbox') {
        value = field.checked
      } else if (field.type === 'number') {
        value = parseInt(field.value) || 0
      } else {
        value = field.value
      }

      // Route to correct place in data structure
      if (fieldName === 'name') {
        data.name = value
      } else if (fieldName === 'level') {
        data.level = value
      } else if (fieldName === 'xp') {
        data.xp = value
      } else if (fieldName.startsWith('stat_')) {
        const stat = fieldName.replace('stat_', '')
        data.hero_data.stats[stat] = value
      } else if (fieldName.startsWith('deb_')) {
        const stat = fieldName.replace('deb_', '')
        data.hero_data.debilities[stat] = value
      } else if (fieldName.startsWith('move_')) {
        // Handle moves separately - we'll collect them all at once
      } else {
        // hpCurrent, hpMax, armor, damage, equipment, condition, notes
        data.hero_data[fieldName] = value
      }
    })

    // Collect moves
    const moves = []
    const moveItems = this.element.querySelectorAll('.move-edit-item')
    moveItems.forEach((item, index) => {
      const nameInput = item.querySelector(`[data-field="move_${index}_name"]`)
      const descInput = item.querySelector(`[data-field="move_${index}_desc"]`)

      if (nameInput && descInput) {
        moves.push({
          name: nameInput.value,
          desc: descInput.value
        })
      }
    })
    data.hero_data.moves = moves

    return data
  }

  addMove(event) {
    event.preventDefault()

    const movesList = this.movesListTarget
    const currentMoves = movesList.querySelectorAll('.move-edit-item')
    const newIndex = currentMoves.length

    const moveItem = document.createElement('div')
    moveItem.className = 'move-edit-item'
    moveItem.innerHTML = `
      <div class="move-edit-header">
        <input type="text"
               class="move-edit-name-input"
               value=""
               data-action="input->hero-editor#scheduleUpdate"
               data-field="move_${newIndex}_name"
               placeholder="Ability Name"
               maxlength="100">
        <button type="button"
                class="move-remove-btn"
                data-action="click->hero-editor#removeMove"
                data-index="${newIndex}">✕</button>
      </div>
      <textarea class="move-edit-desc-input"
                data-action="input->hero-editor#scheduleUpdate"
                data-field="move_${newIndex}_desc"
                placeholder="Ability description..."
                maxlength="500"></textarea>
    `

    movesList.appendChild(moveItem)
    this.scheduleUpdate({ target: { dataset: { field: 'moves' } } })
  }

  removeMove(event) {
    event.preventDefault()

    const item = event.target.closest('.move-edit-item')
    if (item) {
      item.remove()

      // Re-index all moves
      const moveItems = this.movesListTarget.querySelectorAll('.move-edit-item')
      moveItems.forEach((moveItem, index) => {
        const nameInput = moveItem.querySelector('.move-edit-name-input')
        const descInput = moveItem.querySelector('.move-edit-desc-input')
        const removeBtn = moveItem.querySelector('.move-remove-btn')

        if (nameInput) nameInput.dataset.field = `move_${index}_name`
        if (descInput) descInput.dataset.field = `move_${index}_desc`
        if (removeBtn) removeBtn.dataset.index = index
      })

      this.scheduleUpdate({ target: { dataset: { field: 'moves' } } })
    }
  }

  updateStatus(message, isSuccess = null) {
    if (!this.hasStatusTarget) return

    this.statusTarget.textContent = message

    if (isSuccess === true) {
      this.statusTarget.style.color = 'var(--accent-green)'
      setTimeout(() => {
        this.statusTarget.textContent = ''
      }, 2000)
    } else if (isSuccess === false) {
      this.statusTarget.style.color = 'var(--accent-blood-light)'
    } else {
      this.statusTarget.style.color = 'var(--text-secondary)'
    }
  }
}

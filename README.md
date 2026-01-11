# Yar'og (Dungeon World)

A set of tools to play Dungeon World with friends powered by Ruby On Rails.

## Features

### Master Dashboard (`/master`)
- **Games Management**: Create games, add heroes by code, auto-saving notes
- **Heroes Management**: List, search, and fully edit heroes
- **Editable Hero Detail**: Inline editing with auto-save (stats, abilities, equipment, etc.)
- **Game View**: Large 2-column hero cards (data + scrollable logs), real-time updates

### Player Interface (`/hero.html`)
- Offline-first hero sheet with localStorage
- Auto-sync with server (3s debounce)
- Dice rolling with cooldowns
- Full character management

## TODO

- ✅ ~~improve UI/UX for hero page~~ (Master dashboard completed)
- Add version increment to master hero updates
- Add audit logs for DM actions
- optimize hero page for 4k screen
- allow rolls with modifiers
- Add hero filtering in game view
- Export game state as PDF

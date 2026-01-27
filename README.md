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

### Current Features
- ✅ ~~improve UI/UX for hero page~~ (Master dashboard completed)
- Add version increment to master hero updates
- Add audit logs for DM actions
- optimize hero page for 4k screen
- allow rolls with modifiers
- Add hero filtering in game view
- Export game state as PDF

### UI Library (`/uilib.html`)
Comprehensive component library available at `public/uilib.html` with dark/light theme support.

**Completed Components:**
- ✅ Buttons (all variants)
- ✅ Badges & Labels
- ✅ Form Elements (inputs, selects, textareas, number controls)
- ✅ Custom Checkboxes
- ✅ Tables
- ✅ Stat Boxes (HP, Armor, Damage)
- ✅ Progress Bars
- ✅ Move/Ability Cards
- ✅ Collapsible Panels
- ✅ Tabs Navigation
- ✅ Alerts & Toasts
- ✅ Dice Result Display
- ✅ Party Member Cards
- ✅ Character Avatars
- ✅ Layout Grids
- ✅ Utility Classes

**Planned Features:**

#### 🗺️ Map & Visual Elements
- [ ] Canvas for drawing maps with freehand tool
- [ ] Pen/eraser/shapes drawing tools
- [ ] Grid overlay (square/hex) for tactical positioning
- [ ] Character tokens/markers (draggable)
- [ ] Fog of War (reveal/hide areas)
- [ ] Image upload for battle maps and locations
- [ ] Zoom/Pan controls for large maps
- [ ] Measurement tool (show distance between points)
- [ ] Token library (presets for common monsters/PCs)
- [ ] Map layers (background, grid, tokens, effects)

#### ⚔️ Combat Tracker
- [ ] Initiative order with visual turn tracker
- [ ] Current player highlight
- [ ] Enemy HP tracker with quick health bars
- [ ] Status effects icons (poisoned, stunned, blessed, etc.)
- [ ] Round counter
- [ ] Quick action buttons (damage, heal, end turn)
- [ ] Death saves tracker (3-strike visual system)
- [ ] Surprise round indicator
- [ ] Delay/Ready action markers

#### 🎭 GM Tools
- [ ] Scene description box (large text area for setting)
- [ ] NPC quick cards (collapsible with stats/info)
- [ ] Encounter builder (add/remove enemies quickly)
- [ ] Loot generator with quick distribution
- [ ] Random tables (names, events, encounters)
- [ ] Custom table builder
- [ ] Roll on table button
- [ ] Monster stat blocks (expandable enemy info)
- [ ] Quick NPC generator
- [ ] Location/Scene cards

#### 📊 Session Management
- [ ] Event timeline/log of session events
- [ ] Quest tracker with checkboxes
- [ ] Relationship/Bond map (visual web)
- [ ] Session clock (game time/real time)
- [ ] XP tracker and distribution
- [ ] Milestone tracker
- [ ] Session notes with timestamps
- [ ] Recap generator

#### 💬 Communication
- [ ] Message log/chat (scrollable history)
- [ ] GM whisper (private messages to players)
- [ ] Narrative display (large text for dramatic moments)
- [ ] Dice roll announcements in chat
- [ ] Action descriptions in log
- [ ] Color-coded messages by type
- [ ] Chat commands (e.g., /roll, /whisper)

#### 🎲 Advanced Dice
- [ ] Dice pool builder (multiple dice types: 2d6+1d4+2)
- [ ] Advantage/Disadvantage (roll 2, take higher/lower)
- [ ] Roll history with timestamps
- [ ] Reroll mechanic
- [ ] Custom dice (upload faces/outcomes)
- [ ] Exploding dice
- [ ] Success counting (e.g., roll d6 pool, count 5+)
- [ ] Dice macros (save common roll combinations)

#### 👥 Party Management
- [ ] Turn order indicator (who's acting now)
- [ ] Group initiative roller
- [ ] Shared resources tracker (party gold, rations, etc.)
- [ ] Party inventory
- [ ] Resource pool (e.g., inspiration, fate points)
- [ ] Party bonds/relationships display
- [ ] Party composition summary

#### 📚 Reference & Cards
- [ ] Item cards with descriptions and icons
- [ ] Condition/Status reference (quick lookup)
- [ ] Move reference (searchable list)
- [ ] Equipment database with filtering
- [ ] Spell/Magic reference
- [ ] Rules quick reference
- [ ] Printable character sheets

#### 🎨 Visual Enhancements
- [ ] Sound effect triggers (buttons for ambient sounds)
- [ ] Background music controls
- [ ] Visual effects for critical hits/fails
- [ ] Animated damage numbers
- [ ] Screen shake on big events
- [ ] Particle effects
- [ ] Theme customization (colors, fonts)

#### 🔧 Technical Improvements
- [ ] Export/Import encounters
- [ ] Save map states
- [ ] Undo/Redo for map changes
- [ ] Keyboard shortcuts
- [ ] Mobile-responsive combat tracker
- [ ] Touch gestures for map
- [ ] Print-friendly views
- [ ] Shareable links for sessions

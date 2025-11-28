# The Game With No Name

A 2D side-scrolling pixel art RPG built with Godot 4.3.

## Phase 0 Prototype

This is the initial prototype demonstrating core game mechanics:

- **Player Movement**: Side-scrolling movement with A/D or arrow keys
- **NPC Interaction**: Press E to talk to NPCs when nearby
- **Dialogue System**: Branching dialogue with choices that affect trust
- **Trust System**: NPC relationships tracked with cascade effects
- **Combat System**: Dice-roll based combat resolution
- **Day/Night Cycle**: Visual time-of-day changes
- **Mission System**: One completable mission (The Chapel Theft)

## Controls

| Key | Action |
|-----|--------|
| A / Left Arrow | Move left |
| D / Right Arrow | Move right |
| E | Interact with NPCs |
| 1-9 | Select dialogue options |
| Page Down | Advance time (debug) |
| Page Up | Test combat (debug) |
| Home | Save game (debug) |
| End | Load game (debug) |

## Project Structure

```
The-Game-With-No-Name/
├── project.godot          # Godot project configuration
├── scenes/                # Scene files (.tscn)
│   ├── main/             # Main game scene
│   ├── player/           # Player character
│   ├── npcs/             # NPC base scene
│   ├── ui/               # UI components
│   └── levels/           # Game levels
├── scripts/               # GDScript files
│   ├── autoload/         # Singleton managers
│   ├── player/           # Player logic
│   ├── npcs/             # NPC logic
│   ├── combat/           # Combat system
│   └── ui/               # UI logic
├── data/                  # JSON data files
│   ├── npcs/             # NPC configurations
│   ├── dialogue/         # Dialogue trees
│   └── missions/         # Mission definitions
├── assets/                # Art and audio assets
└── docs/                  # Documentation
```

## Core Systems

### GameManager
Tracks player data including skills, coins, guard rank, and mission progress.

### TrustManager
Manages NPC relationships with trust scores (0-100) and cascade effects when trust changes.

### DialogueManager
Loads and processes dialogue trees from JSON files with support for choices, trust changes, and effects.

### TimeManager
Handles day/night cycle with four time periods: Morning, Afternoon, Evening, Night.

### CombatResolver
Dice-roll combat resolution comparing player skills vs enemy stats.

## The Chapel Theft Mission

The prototype includes one completable mission where you investigate stolen candlesticks:

1. Talk to **Captain Aldric** to receive the mission
2. Question **Mira** the servant to discover she's the thief
3. Return to Captain Aldric with your findings
4. Choose how to resolve the situation (cover-up or strict justice)

Your choices affect trust with multiple NPCs and demonstrate the cascade system.

## Requirements

- Godot 4.3 or later

## Running the Game

1. Open the project in Godot 4.3+
2. Press F5 or click the Play button
3. The game starts in the Castle Great Hall

## License

All rights reserved.

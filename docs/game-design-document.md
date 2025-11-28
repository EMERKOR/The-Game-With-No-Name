# The Game With No Name
## Game Design Document v1.0

---

## 1. Overview

**Title:** The Game With No Name  
**Genre:** RPG / Political Strategy / Narrative Adventure  
**Platform:** Browser and Desktop (prioritize simpler option)  
**Engine:** TBD (Recommended: Godot 4.x)  
**Perspective:** 2D Side-Scrolling  
**Player Count:** Single-player  

**Logline:** A young knight navigates the corrupt politics of a medieval court while unknowingly becoming entangled in an ancient magical war that dwarfs the petty ambitions of kings.

---

## 2. Core Concept

### 2.1 Premise
The player controls Erwin, a 20-year-old knight in the royal guard of a major kingdom. The game begins with Erwin as a hopeful, idealistic young man who believes in the honor of the king and his fellow knights. Through gameplay, Erwin becomes disillusioned as he witnesses corruption, cruelty, and the moral compromises required to climb the aristocratic hierarchy.

### 2.2 Central Question
**Will you do terrible things to gain power?**

Every major decision in the game forces the player to weigh ambition against morality. There is no "good" path to the top — only degrees of compromise.

### 2.3 Dual-Layer Structure
The game operates on two levels:

**Layer 1 — Political Reality:** Court intrigue, guard duties, rank advancement, reputation management. This is what Erwin believes matters.

**Layer 2 — Magical Conflict:** An ancient war between the Sun/Moon Wizards and the Witch of the Dark Forest. This conflict transcends and ultimately supersedes the political layer. Erwin can gain power in both realms, and they interact.

---

## 3. Player Character

**Name:** Erwin  
**Starting Age:** 20  
**Starting Position:** Low-ranking knight in the Royal Guard  
**Ultimate Goal:** Become King (long-term, endgame content)

### 3.1 Character Arc
- **Act 1:** Wide-eyed idealist, believes in the system
- **Act 2:** Disillusionment, forced moral compromises
- **Act 3:** Either corrupted pragmatist or principled rebel (player-determined)
- **Act 4+:** Discovery of magical layer, pursuit of power beyond the throne

---

## 4. Core Gameplay Loop

### 4.1 Daily Structure
The game operates on a day/night cycle. Each day, Erwin has time blocks to allocate:

**Morning:** Training, guard duties, or personal projects  
**Afternoon:** Patrol, missions, court attendance, or free activities  
**Evening:** Social interactions, clandestine meetings, or leisure  
**Night:** Rest, or high-risk activities (tunnels, forbidden areas)

### 4.2 Activity Types

**Mandatory Duties**
- Guard patrols (castle, city districts)
- Training sessions
- Court attendance (periodic)

**Missions**
- Assigned tasks from superiors
- Investigations (crimes, threats, missing persons)
- Personal missions (for allies, love interests, family)
- Faction missions (as relationships develop)

**Free Activities**
- Fishing, hunting
- Helping commoners (builds "Common Folk" reputation)
- Personal projects
- Exploration

### 4.3 Mission Outcomes
Missions do not have binary pass/fail states. Outcomes exist on a spectrum:

- **Exceptional Success:** Maximum rewards, reputation gains
- **Success:** Standard rewards
- **Partial Success:** Reduced rewards, minor penalties
- **Failure:** Reputation loss, rank demotion possible, story continues
- **Critical Failure:** Death (mission restart) or severe consequences

The game continues after most failures. Poor performance makes future gameplay harder, not impossible.

---

## 5. Combat System

### 5.1 Philosophy
Combat is narratively central but mechanically simple. The game is not an action game — it's a decision game where combat is one type of decision.

### 5.2 Combat Flow

1. **Trigger:** Combat situation arises (ambush, duel, battle)
2. **Animation:** Brief visual of both parties drawing weapons/preparing
3. **Freeze Frame:** Screen pauses, UI overlay appears
4. **Stats Display:** 
   - Erwin's relevant stats (weapon skill, armor, items, fatigue, etc.)
   - Opponent's stats (estimated or known based on intel)
   - Calculated win probability (e.g., "73% chance of victory")
5. **Player Choice:**
   - Fight (proceed to dice roll)
   - Retreat (if possible — may have consequences)
   - Negotiate (if applicable)
   - Use Item (if available)
   - Special Action (context-dependent)
6. **Resolution:** Dice roll determines outcome based on probability
7. **Result Animation:** Brief animation showing result
8. **Consequences:** Applied to game state

### 5.3 Factors Affecting Combat Probability
- Weapon skill level
- Weapon quality
- Armor quality
- Fatigue level
- Injuries
- Environmental factors
- Opponent's equivalent stats
- Special items or abilities

---

## 6. Economy System

### 6.1 Currency
A single currency (coins, silver, or similar — name TBD). Economy is simple and straightforward.

### 6.2 Earning Money
- Mission rewards (primary source)
- Task completion for NPCs
- Selling items
- Guard salary (small, steady income)

### 6.3 Spending Money
- Equipment (weapons, armor)
- Items (consumables, gifts for NPCs)
- Bribes and favors
- Services (training, information)
- Property (later game, if applicable)

### 6.4 Economic Choices
Money creates meaningful trade-offs with the trust system. Example scenario:
- Lord A offers 500 coins for a task
- Lord B offers 50 coins for a conflicting task
- Lord A's task damages trust with multiple NPCs
- Lord B's task has minimal trust impact
- Player must weigh financial gain against political cost

### 6.5 Design Principle
Money is a tool for decision-making, not a grind. The player should never need to farm currency — missions and story progression provide sufficient income for normal play.

---

## 7. Progression Systems

### 6.1 Skills
Erwin develops skills through use and training:

**Combat Skills**
- Swordsmanship
- Archery
- Hand-to-hand
- Shield work

**Utility Skills**
- Stealth
- Investigation/Detection
- Persuasion
- Intimidation
- Lockpicking
- Climbing

**Knowledge Skills**
- Court etiquette
- Law and protocol
- History and heraldry
- Magical lore (unlocks in Layer 2)

Skills improve through:
- Dedicated training (time investment)
- Practical use (learning by doing)
- Mentorship (NPC relationships)
- Special items or events

### 6.2 Reputation Systems

**Royal Guard Rank**
A formal hierarchy within the guard. Advancement requires:
- Successful mission completion
- Impressive actions witnessed by superiors
- Political maneuvering
- Time in service

Ranks (preliminary):
1. Initiate
2. Guard
3. Senior Guard
4. Sergeant
5. Lieutenant
6. Captain
7. Commander
8. Lord Commander

**Court Standing**
An informal measure of how Erwin is perceived by the aristocracy. Affects:
- Access to court events
- Mission availability
- NPC interactions
- Marriage prospects

**Common Folk Reputation**
Accumulated through helping commoners, fair treatment, side activities. Initially seems unimportant but becomes critical leverage:
- Can rally commoners for military support
- Popular uprising potential
- Information network among servants and workers
- Safe houses and resources outside the castle

### 6.3 Trust System (NPC Relationships)
Each NPC has a Trust Score: 0-100

- **0-25:** Hostile (actively works against Erwin)
- **26-49:** Unfriendly (uncooperative, may obstruct)
- **50:** Neutral
- **51-74:** Friendly (cooperative, shares information)
- **75-100:** Allied (provides active support, takes risks for Erwin)

Trust changes through:
- Direct interactions
- Mission choices
- Faction affiliations
- Gifts and favors
- Witnessed behavior

**Critical Rule:** NPCs have relationships with each other. Gaining trust with one NPC may automatically decrease trust with their rivals.

---

## 8. Court System

### 7.1 Key Figures
Approximately 15 major NPCs in the court system. Each has:

- Name and title
- Personality profile
- Secret motivations
- Public faction alignment
- Hidden faction alignment (may differ)
- Relationships with other NPCs (ally/rival/neutral)
- Trust thresholds for unlocking content
- Unique missions or storylines

### 7.2 Factions
NPCs belong to factions with competing interests. Preliminary faction concepts:

- **The Crown Loyalists:** Support the King absolutely
- **The Reform Council:** Seek to limit royal power
- **The Old Guard:** Traditional nobility, resist change
- **The Merchants' Friends:** Prioritize trade and wealth
- **The Faith:** Religious faction with moral agenda
- **The Shadows:** Criminal/intelligence network (hidden faction)

Faction membership affects:
- Available missions
- Trust dynamics (helping one faction may hurt standing with another)
- Story branches
- Endgame options

### 7.3 Court Events
Periodic court sessions where:
- Political decisions are made
- Erwin can observe and learn
- Opportunities for social advancement arise
- Intrigue plays out

---

## 9. World Design

### 8.1 Areas
All areas accessible from game start, but content unlocks progressively.

**The Castle**
- Throne room
- Barracks
- Training grounds
- Dungeons
- Secret tunnels (used by thieves, also by king for mistresses)
- Servant quarters

**The Capital City**
- Market district
- Noble quarter
- Common district
- Docks/Harbor
- Temple district

**Surrounding Regions**
- Shipyard
- Farming villages
- The Dark Forest (magical area — high danger)
- Wizard Temple (edge of forest)
- Mining settlement
- Hunting grounds

### 8.2 Day/Night Cycle
Time progresses as actions are taken. Time affects:
- NPC availability
- Location access
- Event triggers
- Certain mechanics (fatigue, danger levels)

Night enables:
- Access to underground tunnels
- Clandestine meetings
- Criminal activities
- Higher danger in some areas

### 8.3 Underground Tunnels
A hidden network beneath the castle and city:
- Used by thieves' guild
- Used by king for secret affairs
- Contains hidden passages to sensitive locations
- High-risk, high-reward exploration
- Gateway to some magical content

---

## 10. Magical Realism Layer

### 9.1 Philosophy
Magic exists but is rare, dangerous, and peripheral to normal society. Most people avoid it. The magical conflict operates on a scale that makes political intrigue seem trivial.

### 9.2 The Dark Forest
- All trees are dead
- Those who enter rarely return
- Survivors become "Shadow People" — enslaved to the Witch
- Contains the Witch's domain
- Boundary between mortal and magical worlds

### 9.3 The Witch
- Ancient, powerful entity
- Commands the Shadow People
- Grows her army from those who enter the forest
- In conflict with the Wizard collective
- Motivations to be developed

### 9.4 The Sun and Moon Wizards
- Collective of magic users
- Temple at the edge of the Dark Forest
- Worship celestial bodies
- Oppose the Witch
- Have their own hierarchy and politics
- Potential allies or manipulators of Erwin

### 9.5 Shadow People
- Former humans transformed by the Witch's magic
- Exist only within the Dark Forest
- Form an army under the Witch's control
- Cannot leave the forest (limitation or choice?)
- May include people Erwin knew

### 9.6 Layer 2 Progression
As Erwin discovers the magical conflict:
- New areas unlock within the Dark Forest
- Magical skills become available
- New faction relationships (Wizards, potentially Witch)
- Stakes escalate beyond the throne
- Dual-power endgame becomes possible

---

## 11. Narrative Structure

### 11.1 Non-Linear Design
The story emerges from player choices rather than following a fixed path. Key principles:

- No single "correct" storyline
- Relationships and reputation shape available content
- Multiple valid endings
- Consequences persist and compound

### 11.2 Story Phases

**Phase 1: The Hopeful Knight**
- Tutorial content
- Establish Erwin's idealism
- Introduce core mechanics
- First missions are straightforward
- Meet initial NPCs

**Phase 2: Cracks in the Foundation**
- Witness corruption
- First moral compromises
- Court politics become visible
- Faction dynamics emerge
- Hints of magical layer

**Phase 3: The Climb**
- Active pursuit of advancement
- Significant moral choices
- Faction alignment solidifies
- Reputation systems fully engaged
- Underground/tunnel content available

**Phase 4: The Revelation**
- Magical layer fully revealed
- Stakes expand beyond politics
- New progression paths open
- Fundamental choice: political or magical power (or both)

**Phase 5+: Endgame**
- Pursuit of throne
- Magical conflict resolution
- Multiple ending branches

### 11.3 Mission Generation
Missions arise from:
- Guard duty assignments (procedural)
- Story triggers (scripted)
- NPC relationships (unlock at trust thresholds)
- Faction membership (faction-specific content)
- Random events (procedural with constraints)
- Player-initiated (pursuing personal goals)

### 11.4 Time Scale
The full game spans years to decades of in-game time, reflecting authentic progression through a medieval career and life.

**Pacing varies by content:**
- Individual missions: Hours to days
- Story arcs/chapters: Weeks to months
- Full political progression: Years
- Complete game (including magical layer): Potentially decades

**Time skips:** Between major story beats, time can advance significantly. The game communicates elapsed time through:
- Visual aging (if implemented)
- NPC dialogue references
- World state changes
- Title cards or narrative transitions

---

## 12. Dialogue System

### 12.1 Structure
Multiple-choice dialogue trees. Player selects from 2-4 response options during conversations.

### 12.2 Dialogue Flow
1. NPC speaks (text displayed in dialogue box)
2. Player presented with response options
3. Player selects response
4. Conversation continues or ends
5. Consequences applied (trust changes, information gained, quest updates)

### 12.3 Response Types
- **Neutral:** Standard responses, minimal impact
- **Favorable:** Increases trust with speaker, may decrease trust with rivals
- **Aggressive:** May intimidate or offend, situationally useful
- **Deceptive:** Lies or manipulation, risks and rewards
- **Inquisitive:** Gather more information before committing

### 12.4 Consequence Visibility
Before selecting a response, the player can see potential impacts:
- Trust changes displayed: "+15 Trust with Lord A" or "-10 Trust with Captain B"
- Some consequences hidden for dramatic effect or when Erwin wouldn't know
- Critical choices flagged visually

### 12.5 Dialogue UI
- Text box at bottom of screen
- Character portraits during conversations
- Response options clearly numbered/selectable
- Trust change indicators next to relevant options
- Camera may focus on speaking characters

---

## 13. Technical Specifications

### 13.1 Recommended Tech Stack

**Engine:** Godot 4.x
- Free and open source
- Excellent 2D support
- GDScript is beginner-friendly
- Exports to web and desktop
- Active community and documentation

**Art Style:** 2D Side-Scrolling Pixel Art
- Horizontal movement and exploration
- 32-64px character sprites with presence and detail
- Atmospheric lighting system (day/night cycle, torchlight, moonlight)
- Parallax scrolling backgrounds for depth
- Water reflections where applicable
- Dark, moody medieval aesthetic
- Reference games: Kingdom, Heartlands, Dark Devotion

**Visual Specifications:**
- Base resolution: 640x360 (scales to modern displays)
- Character sprites: ~48-64px tall
- Animation frames: 4-8 frames per action (walk, idle, etc.)
- Tileset approach: Modular pieces for environments
- Color palette: Limited, cohesive medieval tones with strong day/night variation

**Camera:**
- Follows player horizontally
- Smooth scrolling with slight lag
- Vertical adjustment for multi-level areas (stairs, platforms)
- Cinematic locks for dialogue and events

**Audio:**
- Ambient medieval soundscape
- Location-specific audio
- UI feedback sounds
- Music for key moments (not constant)

### 13.2 Data Architecture

**NPC Data Structure**
```
NPC {
  id: string
  name: string
  title: string
  portrait: image_path
  faction_public: faction_id
  faction_secret: faction_id (nullable)
  personality: personality_profile
  motivations: string[]
  relationships: map<npc_id, relationship_value>
  trust_with_player: int (0-100)
  location_schedule: map<time_block, location_id>
  dialogue_trees: dialogue_id[]
  missions_available: mission_id[]
  unlock_conditions: condition[]
}
```

**Player Data Structure**
```
Player {
  skills: map<skill_id, skill_level>
  guard_rank: int
  court_standing: int
  common_folk_rep: int
  npc_trust: map<npc_id, int>
  faction_standing: map<faction_id, int>
  inventory: item[]
  current_quests: quest[]
  completed_quests: quest_id[]
  flags: map<string, value>  // story state tracking
  current_location: location_id
  current_time: game_time
  fatigue: int
  injuries: injury[]
}
```

### 13.3 Save System
- Multiple save slots
- Autosave at day transitions
- Manual save available in safe locations

---

## 14. Development Roadmap

### Phase 0: Prototype (Current Target)
**Goal:** Prove core mechanics work

Scope:
- One location (Castle)
- 3-5 NPCs
- Basic movement and interaction
- One complete mission
- Combat system prototype
- Trust system prototype
- Day/night cycle
- Basic UI

### Phase 1: Vertical Slice
**Goal:** Complete gameplay loop in limited scope

Scope:
- Castle + Capital City
- 8-10 NPCs
- 5-10 missions
- Full skill system
- Full reputation systems
- Court attendance mechanic
- Tunnel access

### Phase 2: Content Expansion
**Goal:** Full political layer

Scope:
- All standard locations
- All 15 court NPCs
- Faction system complete
- 30+ missions
- Multiple story branches
- Common folk reputation payoff

### Phase 3: Magical Layer
**Goal:** Complete dual-layer experience

Scope:
- Dark Forest accessible
- Witch and Wizard factions
- Magical skills
- Shadow People encounters
- Layer 2 progression
- Expanded endgame

### Phase 4: Polish and Expansion
**Goal:** Full release quality

Scope:
- All endings implemented
- Balance pass
- Audio complete
- Art polish
- Performance optimization
- Extended content

---

## 15. Open Questions

Items requiring further design decisions:

1. **Romance:** Is there a romance system? How deep?

2. **Permadeath consideration:** Should there be a mode where death is permanent?

3. **Aging:** Does Erwin age over the course of the game?

4. **NPC schedules:** How complex should NPC daily routines be?

5. **Procedural vs. scripted balance:** What ratio of handcrafted to generated content?

6. **Mod support:** Is this a consideration for later?

---

## 16. Reference Games

Games to study for inspiration:

**Visual/Art Style:**
- **Kingdom (series)** — Side-scrolling pixel art, atmospheric lighting, day/night cycle, water reflections
- **Heartlands** — Similar aesthetic to Kingdom, medieval setting
- **Dark Devotion** — Dark castle interiors, moody pixel art, side-scrolling exploration
- **Golden Axe** — Character presence and sprite work (classic reference)

**Mechanics/Systems:**
- **Crusader Kings III** — Political intrigue, character relationships, emergent narrative
- **Disco Elysium** — Skill system affecting dialogue, reputation consequences
- **Pentiment** — Medieval setting, investigation, consequence-heavy choices
- **Hades** — Relationship progression through repeated interactions
- **Citizen Sleeper** — Dice-based resolution, time management, multiple factions

---

## Document Control

**Version:** 1.0  
**Created:** [Current Date]  
**Last Updated:** [Current Date]  
**Status:** Initial Draft — Awaiting Review

---

# RAGNARÖK INVICTUS — Claude Code Project Briefing

> *Ragnarök Is Not a Prophecy. It Is an Invasion.*

## Developer
- **Name:** Kent
- **Experience:** Formal education in game design and computer animation
- **Team:** Solo developer
- **Goal:** Ship a finished, polished game on Steam — proof of execution ahead of a planned game studio launch

---

## Tech Stack
- **Engine:** Godot 4.6
- **Language:** GDScript
- **Platform Target:** PC (Steam) primary; PS5 / Xbox Series X aspirational
- **Version Control:** [Add if using Git]
- **Rating Target:** M (Mature 17+)

---

## Game Overview
**Ragnarök Invictus** is a 2D side-scrolling beat 'em up Action RPG set in Norse mythology — radically reinterpreted. Closest commercial comp: **Absolum** (Dotemu, 2025) — side-scrolling beat 'em up with RPG depth, multi-mode combat, and co-op. Ragnarök was never a prophecy. It is an invasion by the **Vörðr**: an ancient silicon-based alien civilization that harvests soul-energy from belief-systems to power their civilization. Norse mythology was a prime target because divine souls (especially Odin's) carry extraordinary energy density.

The player is a mortal Norse warrior who dies in battle, arrives in Valhalla to find it destroyed, and must fight through all Nine Realms to stop the complete annihilation of existence.

---

## Core Pillars
1. **Norse Mythology Reimagined** — familiar gods, creatures, and realms recast in a sci-fi survival epic
2. **Dual-Protagonist Choice** — distinct playstyles and story perspectives
3. **God-Power Harvesting** — collect and wield divine abilities from fallen deities
4. **Alien Tech Adaptation** — reverse-engineer Vörðr weapons using Runic Decoding
5. **Nine Realms Traversal** — interconnected open world via Yggdrasil hub

---

## Protagonists

### Ulfgar (Berserker)
- Heavy weapons: axes, war hammers
- Signature: **Bloodlust** — damage taken temporarily boosts attack speed
- Unique ally: Dolgr, an enslaved Jotunn warchief
- Arc: Pride → Purpose

### Signy (Shield Maiden)
- Spear & shield, tactical zone control
- Signature: **Shield Wall** — parry window that reflects energy attacks
- Unique ally: Brynhildr, a surviving Valkyrie
- Arc: Guardian → Champion

---

## Combat System — Three Modes
2D side-scrolling beat 'em up foundation. Each mode uses the same core input scheme: **Basic attack** (fast combos), **Power attack** (slow, high damage), **Special** (mode-specific ability). Modes are switched on the fly during combat.

| Mode | Description |
|------|-------------|
| **Warrior Mode** | Traditional Norse melee — axes, swords, shields, spears; stamina-driven combos |
| **God-Power Mode** | Divine abilities (uses Godforce resource); up to 6 equipped at once |
| **Vörðr Mode** | Captured alien weapons — soul-lancers, gravity anchors, phase cloaks |

### Resources
- **Health** — standard HP
- **Stamina** — dodges, sprints, heavy attacks
- **Godforce** — fuels god-powers; replenished by kills and soul-shards
- **Vörðr Charge** — powers alien weapons; looted from enemies/stations
- **Resonance** — fills with combat intensity; triggers berserk state

---

## God-Power System
Gods encountered across realms grant divine abilities. Up to 6 equipped at a time, upgradeable via shrine offerings.

| God | Realm | Power |
|-----|-------|-------|
| Tyr | Valhalla (Act II) | Rune of War (first power) |
| Thor | Nidavellir | Thunder Strike — area lightning |
| Freya | Alfheim | Seidr Weave — healing & barrier |
| Loki | Helheim | Shapeshifter Protocol — disguise & misdirection |
| Heimdall | Asgard ruins | All-Sight — reveals hidden enemies/weak points |
| Skadi | Niflheim | Winter's Fury — cold area denial |
| Baldur | Helheim | Invulnerability Pulse |
| Odin | Final Act | All-Father's Will (ultimate) |

---

## Story Structure
- **Act I** — Midgard: last battle, killed by the Fenrir-Engine (a Vörðr bioweapon)
- **Act II** — Valhalla: halls destroyed, Tyr grants first god-power and the truth
- **Act III** — Nine Realms (open world): free gods, sabotage Vörðr installations, build resistance
- **Act IV** — Niflheim: board and destroy the Soulforge; face Vörðr Prime

### Three Endings
| Ending | Condition | Outcome |
|--------|-----------|---------|
| The Sacrifice | Destroy Soulforge from inside | Protagonist dies; becomes legend |
| The Liberation | Free all major gods first | Gods return; protagonist ascends |
| The Eternal Raider | Betray more than 4 gods (leave them captured or allow their deaths) | Dark ending — see below |

#### The Eternal Raider — Extended Notes
After defeating Vörðr Prime (a takeover, not just a kill — see Key Characters), the protagonist claims leadership of the Vörðr. They may choose to bring willing Norse survivors with them. The merged civilization — Vikings and Vörðr unified — is reborn as the **VIKORDR**. They abandon the Nine Realms forever, sailing the cosmos as soul-raiders: not conquering for land or glory, but harvesting divine energy from belief-systems across the universe. Ragnarök wasn't an ending. It was a launch.

*Note: VIKORDR lore, composition, and mechanics are placeholder — subject to revision.*

---

## The Nine Realms

| Realm | Tone | Special Mechanic |
|-------|------|-----------------|
| Midgard | War-torn; alien debris fields | Civilian rescue; mortal resistance |
| Valhalla/Asgard | Shattered gold; alien command fortress | God-memory fragments — relive Norse myth |
| Helheim | Bioluminescent soul rivers | Soul tether — pull captured souls for power |
| Jotunheim | Giant labor camps | Direct liberated giants to attack installations |
| Nidavellir | Dwarven-alien industrial fusion | Best alien-tech decoding / crafting hub |
| Alfheim | Power-generation array | Energy disruption puzzles |
| Svartalfheim | Contested guerrilla zone | Stealth-heavy dark elf ally missions |
| Muspelheim | Fire; Surtr corrupted | Environmental hazard traversal |
| Niflheim | Blizzard wastes; buried dreadnought | Discovery — decode ancient Vörðr ship |

---

## Key Characters

### Allies
- **Tyr** — first contact; grants Rune of War; dies
- **Brynhildr** — Signy's Valkyrie ally; scout/guide
- **Dolgr** — Ulfgar's giant ally; breaks free from slavery
- **Loki** — appears to collaborate with Vörðr; actually a double agent
- **Andvari** — dwarf artificer; reverse-engineers alien tech
- **Morana** — dark elf resistance leader; potential romance option

### Antagonists
- **Vörðr Prime** — final boss; absorbed divine souls; partially transcendent. **Conditional behavior:** on The Sacrifice / The Liberation paths, this is a destroy-and-kill fight. On The Eternal Raider path, defeating Prime is a takeover — the protagonist defeats and supplants them to claim Vörðr leadership.
- **Soul-Warden Khrael** — mid-game boss; wields Odin's spear
- **Surtr (Corrupted)** — fire giant with alien neural implant; Muspelheim boss
- **The Fenrir-Engine** — bioweapon that opens the game; returns in Act III
- **Vörðr Inquisitor** — recurring elite mini-boss; adaptive AI

---

## Scope Targets
| Parameter | Target |
|-----------|--------|
| Main story | 25–30 hours |
| Full completion | 60–80 hours |
| Realms | 9 fully explorable biomes |
| God-powers | 7 total (6 base + Odin ultimate) |
| Major bosses | 12+ |
| Lore collectibles | 150+ runestones/murals |
| Endings | 3 distinct + minor variations |

---

## Monetization
- **Premium single-player** — no pay-to-win, no gameplay-locked content
- **Cosmetic DLC:** armor sets, weapon skins, Yggdrasil themes
- **Story DLC:** "The Soulforge Chronicles" — 4–6hr Loki prequel

---

## UI Philosophy
- Minimal Norse-runic HUD aesthetic
- No floating damage numbers by default
- God-power radial menu: appears on demand only
- Realm map: stylized Yggdrasil diagram
- Runic Codex: in-world lore system (carved-stone journal feel)

---

## Audio Direction
- **Norse layer:** live drums, bone flutes, hurdy-gurdy, choral chanting
- **Vörðr layer:** processed synths, subharmonic drones, alien polyrhythms
- The two layers **merge** as the player gains power — representing transformation
- By Act IV: a single unified hybrid score

---

## Co-op
- **Modes:** Local co-op + online co-op (mirrors Absolum's implementation)
- **Player count:** 2 players only
- **Character assignment:** Player 1 = Ulfgar, Player 2 = Signy (forced pairing — no free choice)
- **Gameplay impact:** Enemy difficulty scales up in co-op; no changes to story, endings, or progression
- **Story impact:** None — co-op is a pure gameplay layer on top of the single-player experience
- **Dev priority: Late-timeline stretch feature.** Core single-player experience ships first. Co-op is only added if time and scope allow. Do not design systems that assume co-op exists.

---

## What Claude Should Know About This Project
- **Scope discipline is critical.** This is a solo dev project. Push back on feature creep. The goal is a finished, shippable game — not a perfect one.
- **Kent has formal game design training.** Don't over-explain basics.
- **Favor practical solo-dev solutions** over architectures that assume a team.
- **GDScript only** — do not suggest C# unless Kent specifically asks.
- **Godot 4.6 syntax only** — do not use deprecated Godot 3 patterns.
- **When suggesting systems**, ask: can one developer reasonably build and maintain this?
- **Steam is the release target.** Decisions about scope, polish, and marketing should keep that in mind.
- **Co-op is a late-timeline stretch feature.** Never design systems assuming co-op exists. Single-player ships first.

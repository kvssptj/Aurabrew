# AuraBrew

A personal iOS coffee companion — guided brew sessions and daily caffeine tracking.

![iOS 17+](https://img.shields.io/badge/iOS-17%2B-black?style=flat-square&logo=apple)
![SwiftUI](https://img.shields.io/badge/SwiftUI-blue?style=flat-square)
![SwiftData](https://img.shields.io/badge/SwiftData-purple?style=flat-square)

---

## About

AuraBrew is a personal iOS app built to master manual coffee brewing and keep tabs on daily caffeine intake. It covers guided step-by-step brew sessions for V60, AeroPress, and French Press — with adjustable ratios, a countdown timer, haptic feedback, and a brew journal to track every cup.

---

## Features

### Brew Guide

Three brew methods with 8 recipes across difficulty levels:

| Method | Recipe | Difficulty |
|---|---|---|
| V60 | Classic | Easy |
| V60 | Iced Coffee | Easy |
| V60 | Hoffmann V60 | Intermediate |
| V60 | Hoffmann Iced V60 | Intermediate |
| AeroPress | Classic | Easy |
| AeroPress | Inverted | Intermediate |
| AeroPress | Hoffmann AeroPress | Advanced |
| French Press | Hoffmann French Press | Advanced |

Each recipe includes an adjustable coffee amount slider (8–30g). Water volumes and pour amounts scale automatically. Step details include water temperature, pour amounts, duration, and pour technique notes.

### Active Brew Timer

Full-screen guided brew mode with:

- Step-by-step instructions and a visual progress bar
- Circular countdown timer for timed steps; "Tap when ready" for open-ended steps
- Pause / Resume support
- Haptic feedback on step completion and brew end
- Brew completion overlay showing total brew time, flowing directly into journal logging

### Caffeine Tracker

The home screen shows:

- Today's total caffeine (mg) with a progress bar against the FDA 400mg daily limit — bar turns red when the limit is approached or exceeded
- Count of brews today and total coffee consumed (g)

Caffeine extraction rates used per method: V60 12 mg/g, AeroPress 15 mg/g, French Press 10 mg/g.

### Ratio Calculator

- Coffee (5–50g) and ratio (10:1–20:1) sliders
- Four quick presets: Strong (1:12), Balanced (1:15), Classic (1:16), Light (1:18)
- Instant water output in ml or fl oz
- "Log This Brew" button to save directly to the journal

### Brew Journal

- Log every brew: recipe name, method, coffee bean, grind size, amounts, rating (1–5 stars), notes
- Auto-filled when logging from an active brew session or the ratio calculator
- Chronological list (newest first), swipe-to-delete
- Detail view for each entry

---

## Tech Stack

| | |
|---|---|
| Platform | iOS 17+ |
| UI | SwiftUI |
| Persistence | SwiftData |
| Architecture | `@Observable` ViewModels, `navigationDestination` routing |
| Dependencies | None — pure Apple frameworks |

---

## Screenshots

<!-- Screenshots coming soon -->

---

## Getting Started

1. Clone the repo
2. Open `AuraBrew.xcodeproj` in Xcode 15+
3. Set your Development Team under project settings → Signing & Capabilities
4. Build and run on a simulator or device running iOS 17+

---

## Personal Note

Built to dial in V60 and AeroPress technique and stop guessing caffeine intake.

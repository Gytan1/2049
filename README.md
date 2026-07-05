# 2048

An iOS implementation of the classic **2048** puzzle game, built with Swift and UIKit.

Slide numbered tiles on a 4x4 grid to merge matching values. Each merge doubles the tile's value and adds to your score — reach 2048 (or beyond) to win.

## Project structure

- `2048/` — app source code
  - `ViewController.swift` — main game screen and UI wiring
  - `GridManager.swift` — core game logic (grid state, tile merging/compression, spawning random tiles)
  - `GestureManager.swift` — swipe gesture handling for player moves
  - `TileCell.swift` — individual tile view/cell
  - `InfoViewController.swift` — info/help screen
  - `AppDelegate.swift`, `SceneDelegate.swift` — app lifecycle
  - `Base.lproj/` — storyboards (`Main.storyboard`, `LaunchScreen.storyboard`)
  - `Assets.xcassets/` — app icon and color assets
- `2048Tests/` — unit test target
- `2048UITests/` — UI test target

## Requirements

- Xcode (recent version)
- iOS Simulator or device running iOS 17.5+

## Running the app

1. Open `2048.xcodeproj` in Xcode.
2. Select a simulator (or a connected device) as the run destination.
3. Press `Cmd+R` (or click the Run button) to build and launch the app.

## Running the tests

The project includes both a unit test target (`2048Tests`) and a UI test target (`2048UITests`). Run them from Xcode with `Cmd+U`, or via `Product > Test`.

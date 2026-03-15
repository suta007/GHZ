# Garden Horizons Script Structure

This document provides an overview of the variables and functions available in the `src` directory to serve as a reference for development.

## 📂 Root Files

### `EfHub.luau`
The main orchestrator of the project.
- **Variables:**
  - `Registry`: The shared table containing references to all initialized modules.
- **Functions:**
  - `LoadModules()`: Loads all core, functional, and UI modules into a Registry.
  - `EfHub.Initialize()`: The entry point that initializes all modules in the correct order.
  - `EfHub.RunTask(Registry)`: Starts the background process loop for the action queue.

### `loader.luau`
The entry point script for loading the project from GitHub.
- **Variables:**
  - `BaseUrl`: GitHub repository source URL.
  - `GHZ_REMOTE`: Global function to fetch and load remote modules.
- **Functions:**
  - `GetRemote(path)`: Fetches a `.luau` file from GitHub and executes it.

---

## 📂 Core

### `Core/fVar.luau`
Global state and control variables shared across modules.
- **Variables:**
  - `fVar.actionQueue`: List of tasks to be processed by the process loop.
  - `fVar.SutaDistLimit`: Distance threshold for teleporting vs tweening (default: 15).
  - `fVar.SutaYoffset`: Height offset for movement (default: 4).
  - `fVar.Pos`: Table containing CFrames for `GearShop`, `SeedShop`, `Botanist`, `Sell`, and `Quest`.
  - **Control Toggles:** `isPlanting`, `isBuyingSeed`, `isBuyingGear`, `isProcessing`, `isSelling`, `HarvestPause`, `Harvesting`, `isQuestClaiming`.
- **Functions:**
  - `fVar.ResetControlVar()`: Resets all control booleans and clears the action queue.
  - `fVar.LockDownControlVar()`: Sets all control booleans to `true` (stops all auto actions).
  - `fVar.IsBuying()`: Returns true if any buying or selling operation is active.

### `Core/sData.luau`
Static data and game definitions (Seeds, Shop Items, Mutations).
- **Variables:**
  - `sData.SeedShopTable`: List of available seeds.
  - `sData.GearShopTable`: List of available gear.
  - `sData.PlantDataTable`: List of plant names.
  - `sData.MutationDataTable`: List of mutation types.
  - `sData.PlantDataBlackTable`: Blacklist-ready list of plants (starts with "NONE").

---

## 📂 Modules

### `Modules/Main.luau`
Core gameplay automation (Planting, Harvesting, Selling).
- **Functions:**
  - `Main.Initialize(Registry)`: Sets up local references.
  - `Main.AutoPlantsSeeds()`: Logic for automatically planting seeds from the backpack.
  - `Main.CheckCrops(fruit, config)`: Validates if a fruit meets harvest criteria.
  - `Main.ScanCrops()`: Scans for harvestable plants and populates `HarVestCropsList`.
  - `Main.HarvestCrops()`: Logic for harvesting a single plant from the list.
  - `Main.AutoSellCrops()`: Handles teleporting to sell area and selling items.

### `Modules/Shop.luau`
Shop and purchasing automation.
- **Functions:**
  - `Shop.Initialize(Registry)`: Sets up local references.
  - `Shop.AutoBuyItem(ShopType, Items, DropdownValue)`: Universal function to buy items.
  - `Shop.AutoBuySeed(Items)`: Wraps `AutoBuyItem` for seeds.
  - `Shop.AutoBuyGear(Items)`: Wraps `AutoBuyItem` for gear.

### `Modules/Utils.luau`
General utility functions for movement, teleportation, and data parsing.
- **Functions:**
  - `Utils.Initialize(Registry)`: Initializes player plot data.
  - `Utils.GetSelectedItems(DropdownValue)`: Converts Fluent dropdown table to a list.
  - `Utils.GetRandomPlantPosition()`: Calculates a random valid planting spot in the player's plot.
  - `Utils.SafeTeleport(targetCFrame)`: Safely moves the player to a position.
  - `Utils.SetNoClip(state)`: Enables or disables noclip.
  - `Utils.TweenToTarget(targetCFrame, speed)`: Smoothly moves the player to a target position.
  - `Utils.ParseFruitUuid(rawUuid)`: Splits UUID from index (e.g., `uuid:index`).

### `Modules/EventDrive.luau`
Handles incoming signals from the game server (RemoteEvents).
- **Functions:**
  - `EventDrive.Initialize(Registry)`: Starts monitoring remote events.
  - `EventDrive.hookIncoming(remote)`: Connects to `OnClientEvent` to monitor data updates.
  - `AutoClaimQuest(QuestData)`: Automatically claims finished daily/weekly quests.

### `Modules/Process.luau`
The task scheduler/worker.
- **Functions:**
  - `Process.processQueue()`: Loops through `fVar.actionQueue` and executes functions one by one.

---

## 📂 UI

### `UI/Window.luau`
Creates the main Fluent GUI window.
- **Functions:**
  - `Window.Initialize(Registry)`: Builds the main window and theme.
  - `Window.Finalize()`: Adds settings tabs and loads saved configurations.
  - `Window.QuickSave()`: Saves current settings to file.

### `UI/Tabs/MainTab.luau`
Builds the "Main" tab containing Planting, Harvesting, and Selling controls.

### `UI/Tabs/ShopTab.luau`
Builds the "Shop" tab containing Auto-Buy Seed and Gear controls.

---

## 📂 Addons

### `Addons/CollapsibleSection.lua`
Extends Fluent with collapsible sections for better UI organization.
- **Functions:**
  - `AddCollapsibleSection(Title, Opened)`: Adds a new collapsible group to a tab.


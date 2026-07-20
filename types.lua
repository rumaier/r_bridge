---@meta r_bridge
--- LuaLS definition file for the global `bridge` API created by `@r_bridge/init.lua`.
--- Loaded across the multi-root workspace via `Lua.workspace.library` (see r_scripts.code-workspace).

---FiveM built-in 3D vector (`vector3(x, y, z)`).
---@class vector3
---@field x number
---@field y number
---@operator add(vector3): vector3
---@operator sub(vector3): vector3
---@operator mul(number|vector3): vector3
---@operator div(number|vector3): vector3
---@operator unm: vector3

---Creates a FiveM `vector3`.
---@param x number
---@param y number
---@param z number
---@return vector3
function vector3(x, y, z) end

---@class BridgeNameResult
---@field first string
---@field last string

---@class BridgeJob
---@field name string
---@field label string
---@field grade number
---@field gradeLabel string

---@class BridgeItem
---@field name string
---@field count number
---@field metadata table?
---@field slot number?
---@field stack boolean?

---@class BridgeSkinOutfits
---@field Male table?
---@field Female table?

---@class BridgeFramework
local BridgeFramework = {}

---Returns the detected framework resource name.
---@return 'qbx_core'|'qb-core'|'es_extended'
function BridgeFramework.getDetected() end

---**(client)** Whether the local player is loaded.
---@return boolean
function BridgeFramework.isPlayerLoaded() end

---**(server)** Get a player's identifier (citizenid / ESX identifier).
---@param src number
---@return string?
function BridgeFramework.getPlayerIdentifier(src) end

---Get a player's first and last name.
---**(client)** Call with no args for the local player.
---**(server)** Pass `src` for a remote player.
---@overload fun(): BridgeNameResult?
---@param src number
---@return BridgeNameResult?
function BridgeFramework.getPlayerName(src) end

---**(server)** Get a player's job data.
---@param src number
---@return BridgeJob?
function BridgeFramework.getPlayerJob(src) end

---Get a metadata value.
---**(client)** `getPlayerMetadata(key)`
---**(server)** `getPlayerMetadata(src, key)`
---@overload fun(key: string): any
---@param src number
---@param key string
---@return any
function BridgeFramework.getPlayerMetadata(src, key) end

---**(server)** Set a metadata value for a player.
---@param src number
---@param key string
---@param value any
function BridgeFramework.setPlayerMetadata(src, key, value) end

---**(server)** Get a player's account balance. Accepts `cash`/`money` interchangeably.
---@param src number
---@param account string
---@return number?
function BridgeFramework.getBalance(src, account) end

---**(server)** Add money to a player's account. Accepts `cash`/`money` interchangeably.
---@param src number
---@param account string
---@param amount number
function BridgeFramework.addBalance(src, account, amount) end

---**(server)** Remove money from a player's account. Accepts `cash`/`money` interchangeably.
---@param src number
---@param account string
---@param amount number
function BridgeFramework.removeBalance(src, account, amount) end

---**(server)** Add money to a society account.
---@param society string
---@param amount number
function BridgeFramework.addSocietyBalance(society, amount) end

---**(server)** Remove money from a society account.
---@param society string
---@param amount number
function BridgeFramework.removeSocietyBalance(society, amount) end

---**(server)** Register a usable item callback.
---@param item string
---@param cb fun(src: number, ...: any)
function BridgeFramework.registerUsableItem(item, cb) end

---**(client)** Apply a temporary outfit. Uses `Male` or `Female` based on player gender.
---@param outfits BridgeSkinOutfits
function BridgeFramework.setSkin(outfits) end

---**(client)** Restore the player's saved skin.
function BridgeFramework.restoreSkin() end

---@class BridgeInventory
local BridgeInventory = {}

---Returns the detected inventory resource name.
---@return 'ox_inventory'|'qb-inventory'|'codem-inventory'|'origen_inventory'|'tgiann-inventory'
function BridgeInventory.getDetected() end

---**(client)** Returns a NUI image path format string (use with `string.format`, `%s` = item name).
---@return string
function BridgeInventory.getIconPath() end

---**(server)** Add an item to a player's inventory.
---@param src number
---@param item string
---@param count number
---@param metadata table?
---@return boolean
function BridgeInventory.addItem(src, item, count, metadata) end

---**(server)** Remove an item from a player's inventory.
---@param src number
---@param item string
---@param count number
---@param metadata table?
---@param slot number?
---@return boolean
function BridgeInventory.removeItem(src, item, count, metadata, slot) end

---**(server)** Get the first matching item from a player's inventory.
---@param src number
---@param item string
---@param metadata table?
---@return BridgeItem?
function BridgeInventory.getItem(src, item, metadata) end

---**(server)** Get the total count of an item in a player's inventory.
---@param src number
---@param item string
---@return number
function BridgeInventory.getItemCount(src, item) end

---**(server)** Get a player's full inventory (normalized item tables).
---@param src number
---@return BridgeItem[]?
function BridgeInventory.getInventory(src) end

---**(server)** Whether a player can carry the given item and count.
---@param src number
---@param item string
---@param count number
---@return boolean
function BridgeInventory.canCarry(src, item, count) end

---**(server)** Set metadata on an item in a specific slot.
---@param src number
---@param item string
---@param slot number
---@param metadata table
---@return boolean?
function BridgeInventory.setItemMetadata(src, item, slot, metadata) end

---Get shared item definition/info for an item name. Shape varies by inventory provider.
---@param item string
---@return table?
function BridgeInventory.getItemInfo(item) end

---@class BridgeTarget
local BridgeTarget = {}

---Returns the detected target resource name.
---@return 'ox_target'|'qb-target'
function BridgeTarget.getDetected() end

---Add global ped target options. Option tables follow ox_target style (`label`, `icon`, `onSelect`, etc.).
---@param options table
function BridgeTarget.addGlobalPedOptions(options) end

---Remove a global ped target option by name.
---@param name string
function BridgeTarget.removeGlobalPedOption(name) end

---Add global player target options. Option tables follow ox_target style (`label`, `icon`, `onSelect`, etc.).
---@param options table
function BridgeTarget.addGlobalPlayerOptions(options) end

---Remove a global player target option by name.
---@param name string
function BridgeTarget.removeGlobalPlayerOption(name) end

---Add target options to a local entity.
---@param entity number
---@param options table
function BridgeTarget.addLocalEntity(entity, options) end

---Remove target options from a local entity.
---@param entity number
function BridgeTarget.removeLocalEntity(entity) end

---Add target options for a model.
---@param model string|number|table
---@param options table
function BridgeTarget.addModel(model, options) end

---Remove target options for a model.
---@param model string|number|table
function BridgeTarget.removeModel(model) end

---Add a sphere/circle zone. Returns a zone id (`number` for ox_target, `string` for qb-target).
---@param coords vector3
---@param radius number
---@param options table
---@param debug boolean?
---@return number|string
function BridgeTarget.addZone(coords, radius, options, debug) end

---Remove a zone by id.
---@param id number|string
function BridgeTarget.removeZone(id) end

---@class BridgeInterface
local BridgeInterface = {}

---Show a notification (ox_lib notify).
---@param title string
---@param text string
---@param type string
---@param duration number?
function BridgeInterface.notify(title, text, type, duration) end

---Show an alert dialog (ox_lib alertDialog).
---@param data table
---@return string?
function BridgeInterface.alert(data) end

---Register a context menu (ox_lib registerContext).
---@param data table
function BridgeInterface.registerContext(data) end

---Show a registered context menu by id.
---@param id string
function BridgeInterface.showContext(id) end

---Hide the current context menu.
function BridgeInterface.hideContext() end

---Show the HUD. Currently a no-op stub.
function BridgeInterface.showHud() end

---Hide the HUD. Currently a no-op stub.
function BridgeInterface.hideHud() end

---Show an input dialog (ox_lib inputDialog).
---@param heading string
---@param rows table
---@param options table?
---@return table?
function BridgeInterface.input(heading, rows, options) end

---Close the active input dialog.
function BridgeInterface.closeInput() end

---Start a progress circle (ox_lib progressCircle).
---@param data table
---@return boolean
function BridgeInterface.progress(data) end

---Whether a progress bar/circle is currently active.
---@return boolean
function BridgeInterface.isProgressActive() end

---Cancel the active progress bar/circle.
function BridgeInterface.cancelProgress() end

---Run a skill check (ox_lib skillCheck).
---@param difficulty string|string[]|table
---@param inputs string[]?
---@return boolean
function BridgeInterface.skillCheck(difficulty, inputs) end

---Cancel the active skill check.
function BridgeInterface.cancelSkillCheck() end

---Show text UI (ox_lib showTextUI).
---@param text string
---@param options table?
function BridgeInterface.showTextUi(text, options) end

---Hide text UI.
function BridgeInterface.hideTextUi() end

---Whether text UI is currently open.
---@return boolean
function BridgeInterface.isTextUiOpen() end

---Show GTA help text at the top left of the screen.
---@param text string
---@param duration number? Duration in ms, or `-1` to keep showing until cleared. Defaults to `5000`.
function BridgeInterface.showHelpText(text, duration) end

---Clear all currently displayed help text.
function BridgeInterface.clearHelpText() end

---@class BridgeNatives
local BridgeNatives = {}

---Create a map blip at the given coordinates. Tracked and cleaned up on resource stop.
---@param coords vector3
---@param sprite number
---@param color number
---@param scale number
---@param label string
---@param longRange boolean
---@return number blipId
function BridgeNatives.createBlip(coords, sprite, color, scale, label, longRange) end

---Remove a previously created blip.
---@param id number
function BridgeNatives.removeBlip(id) end

---Set a GPS multi-route to the given coordinates.
---@param coords vector3
---@param color number
function BridgeNatives.setGpsRoute(coords, color) end

---Clear the current GPS multi-route.
function BridgeNatives.clearGpsRoute() end

---Freeze a ped and make it inert (invincible, ignore events).
---@param id number
---@param toggle boolean
function BridgeNatives.setPedInert(id, toggle) end

---Teleport the local player with a screen fade.
---@param coords vector3
---@param heading number
function BridgeNatives.teleportPlayer(coords, heading) end

---Whether a ped is facing an entity within the given angle tolerance.
---@param ped number
---@param entity number
---@param maxAngle number? Maximum angle in degrees. Defaults to `5.0`.
---@return boolean
function BridgeNatives.isPedFacingEntity(ped, entity, maxAngle) end

---Whether a ped is facing coordinates within the given angle tolerance.
---@param ped number
---@param coords vector3
---@param maxAngle number? Maximum angle in degrees. Defaults to `5.0`.
---@return boolean
function BridgeNatives.isPedFacingCoord(ped, coords, maxAngle) end

---Create an object entity. Accepts a model name or hash.
---@param model string|number
---@param coords vector3
---@param heading number
---@param network boolean
---@return number entity
function BridgeNatives.createObject(model, coords, heading, network) end

---Create a ped entity. Accepts a model name or hash.
---@param model string|number
---@param coords vector3
---@param heading number
---@param network boolean
---@return number entity
function BridgeNatives.createPed(model, coords, heading, network) end

---Create a vehicle entity. Accepts a model name or hash.
---@param model string|number
---@param coords vector3
---@param heading number
---@param network boolean
---@return number entity
function BridgeNatives.createVehicle(model, coords, heading, network) end

---Play an animation on an entity.
---@param entity number
---@param dict string
---@param anim string
---@param duration number
---@param flag number
---@param rate number?
function BridgeNatives.playAnimation(entity, dict, anim, duration, flag, rate) end

---Play a particle effect at coordinates. When `loop` is true, stops after `duration` ms.
---@param coords vector3
---@param rotation vector3
---@param asset string
---@param fx string
---@param scale number
---@param loop boolean
---@param duration number?
function BridgeNatives.ptFx(coords, rotation, asset, fx, scale, loop, duration) end

---@class BridgeUtility
local BridgeUtility = {}

---Interactive object placer. Returns placed coords and heading on confirm, or nothing on cancel.
---@param model string|number
---@param offset vector3?
---@param rotation vector3?
---@param minDistance number?
---@param snapToGround boolean?
---@param allowedTerrain table<number, boolean>?
---@return vector3? coords
---@return number? heading
function BridgeUtility.useObjectPlacer(model, offset, rotation, minDistance, snapToGround, allowedTerrain) end

---Whether the object placer is currently active.
---@return boolean
function BridgeUtility.isObjectPlacerActive() end

---@class BridgeVersion
---@field current string Current r_bridge version from resource metadata
local BridgeVersion = {}

---**(server)** Check a resource against the latest published version and print a warning if outdated.
---@param resource string
function BridgeVersion.check(resource) end

---@class Bridge
---@field framework BridgeFramework
---@field inventory BridgeInventory
---@field target BridgeTarget
---@field natives BridgeNatives
---@field interface BridgeInterface
---@field utility BridgeUtility
---@field version BridgeVersion

---@type Bridge
bridge = {
    framework = BridgeFramework,
    inventory = BridgeInventory,
    target = BridgeTarget,
    natives = BridgeNatives,
    interface = BridgeInterface,
    utility = BridgeUtility,
    version = BridgeVersion,
}

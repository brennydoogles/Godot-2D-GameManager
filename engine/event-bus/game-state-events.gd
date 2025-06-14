extends Node


signal SHOW_MENU_REQUESTED(requestedMenu: String)
signal MENU_OPEN
signal MENU_CLOSED
signal CLOSE_MENU_REQUESTED
signal LEVEL_CHANGE_REQUESTED(requestedLevel: String)
signal LEVEL_CHANGE_WITH_START_POSITION_OVERRIDE_REQUESTED(requestedLevel: String, player_start_override: Vector2)
signal PLAYER_TELEPORT_REQUESTED(toLocation: Vector2)

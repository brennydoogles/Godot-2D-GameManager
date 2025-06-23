extends Node


#region Menu Related Signals
signal SHOW_MENU_REQUESTED(
	requestedMenu: String
)
signal CLOSE_MENU_REQUESTED
signal MENU_OPEN
signal MENU_CLOSED
#endregion

#region Level Related Signals
signal LEVEL_CHANGE_REQUESTED(
	requestedLevel: String,
	requestedTransition: String
)
signal LEVEL_CHANGE_WITH_START_POSITION_OVERRIDE_REQUESTED(
	requestedLevel: String, 
	requestedTransition: String,
	player_start_override: Vector2
)
signal LEVEL_VALIDATED
signal PLAYER_ADDED_TO_LEVEL
signal LEVEL_ADDED_TO_TREE
signal LEVEL_REMOVED_FROM_TREE
#endregion

#region Transition Related Signals
signal LEVEL_OUT_TRANSITION_STARTED
signal LEVEL_IN_TRANSITION_STARTED
signal LEVEL_TRANSITION_COMPLETE
#endregion

#region Player Related Signals
signal PLAYER_TELEPORT_REQUESTED(toLocation: Vector2)
#endregion

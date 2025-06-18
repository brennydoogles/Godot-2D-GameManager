class_name PlayerMovementStateMachine
extends Node


@export var starting_state: PlayerMovementState
@export var pause_state: PlayerMovementState
var current_state: PlayerMovementState

func init(parent: Player) -> void:
	for child in get_children():
		child.parent = parent
	change_state(starting_state)
	GameStateEvents.MENU_OPEN.connect(_handle_menu_opened)

func _handle_menu_opened() -> void:
	change_state(pause_state)

func change_state(new_state: PlayerMovementState) -> void:
	if current_state:
		current_state.exit()
	current_state = new_state
	new_state.enter()

func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)

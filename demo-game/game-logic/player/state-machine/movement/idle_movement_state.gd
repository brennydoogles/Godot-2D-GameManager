extends PlayerMovementState

@export
var move_state: PlayerMovementState

func enter() -> void:
	super()
	

func process_input(_event: InputEvent) -> PlayerMovementState:
	var direction: Vector2 = _get_movement_vector()
	if direction != Vector2.ZERO:
		return move_state
	return null

func process_physics(_delta: float) -> PlayerMovementState:
	return null

func process_frame(_delta: float) -> PlayerMovementState:
	return null

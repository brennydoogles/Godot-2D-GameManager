extends PlayerMovementState

@export var idle_state: PlayerMovementState

var menu_closed: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameStateEvents.MENU_CLOSED.connect(_handle_menu_closed_signal)

func _handle_menu_closed_signal() -> void:
	menu_closed = true

func enter() -> void:
	super()
	

func process_input(event: InputEvent) -> PlayerMovementState:
	if menu_closed:
		menu_closed = false
		return idle_state
	return null

func process_physics(delta: float) -> PlayerMovementState:
	return null

func process_frame(delta: float) -> PlayerMovementState:
	return null

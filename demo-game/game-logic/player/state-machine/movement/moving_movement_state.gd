extends PlayerMovementState

@export
var idle_state: PlayerMovementState


const TILE_SIZE: Vector2 = Vector2(GlobalConstants.TILE_SIZE, GlobalConstants.TILE_SIZE)
const TILE_TRANSITION_SPEED = 0.3
var sprite_node_position_tween: Tween


func enter() -> void:
	super()
	

func process_input(event: InputEvent) -> PlayerMovementState:
	var direction: Vector2 = _get_movement_vector()
	if direction == Vector2.ZERO:
		return idle_state
	return null

func process_frame(delta: float) -> PlayerMovementState:
	if Input.is_action_pressed("east"):
		self.animation_name = "walk_east"
	elif Input.is_action_pressed("west"):
		self.animation_name = "walk_west"
	elif Input.is_action_pressed("north"):
		self.animation_name = "walk_north"
	elif Input.is_action_pressed("south"):
		self.animation_name = "walk_south"
	parent.animated_sprite.play(self.animation_name)
	return null

func process_physics(delta: float) -> PlayerMovementState:
	if !sprite_node_position_tween or !sprite_node_position_tween.is_running():
		if Input.is_action_pressed("east") and !parent.ray_cast_east.is_colliding():
			_move_player(Vector2(1, 0))
		elif Input.is_action_pressed("west") and !parent.ray_cast_west.is_colliding():
			_move_player(Vector2(-1, 0))
		elif Input.is_action_pressed("north") and !parent.ray_cast_north.is_colliding():
			_move_player(Vector2(0, -1))
		elif Input.is_action_pressed("south")  and !parent.ray_cast_south.is_colliding():
			_move_player(Vector2(0, 1))
	return null

func _move_player(direction: Vector2) -> void:
	parent.global_position += direction * TILE_SIZE
	if sprite_node_position_tween:
		sprite_node_position_tween.kill()
	sprite_node_position_tween = create_tween()
	sprite_node_position_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	sprite_node_position_tween.tween_property(
		parent.animated_sprite, 
		"global_position", 
		parent.global_position, 
		TILE_TRANSITION_SPEED
		).set_trans(Tween.TRANS_SINE)
	PlayerStateEvents.PLAYER_MOVED.emit()
	

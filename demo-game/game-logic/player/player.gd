class_name Player
extends AbstractPlayer

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var movement_state_machine: PlayerMovementStateMachine = $PlayerMovementStateMachine
@onready var ray_cast_north: RayCast2D = $RayCastNorth
@onready var ray_cast_south: RayCast2D = $RayCastSouth
@onready var ray_cast_east: RayCast2D = $RayCastEast
@onready var ray_cast_west: RayCast2D = $RayCastWest

func _ready() -> void:
	movement_state_machine.init(self)

func _process(delta: float) -> void:
	movement_state_machine.process_frame(delta)

func _physics_process(delta: float) -> void:
	movement_state_machine.process_physics(delta)

func _unhandled_input(event: InputEvent) -> void:
	movement_state_machine.process_input(event)

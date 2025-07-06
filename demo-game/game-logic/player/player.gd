class_name Player
extends AbstractPlayer

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var movement_state_machine: PlayerMovementStateMachine = $PlayerMovementStateMachine
@onready var ray_cast_north: RayCast2D = $RayCastNorth
@onready var ray_cast_south: RayCast2D = $RayCastSouth
@onready var ray_cast_east: RayCast2D = $RayCastEast
@onready var ray_cast_west: RayCast2D = $RayCastWest

@export var stat_nodes : Array[AbstractStat]

func _ready() -> void:
	movement_state_machine.init(self)

func _process(delta: float) -> void:
	movement_state_machine.process_frame(delta)

func _physics_process(delta: float) -> void:
	movement_state_machine.process_physics(delta)

func _unhandled_input(event: InputEvent) -> void:
	movement_state_machine.process_input(event)

func get_stat_node_by_string_name(stat_name: StringName) -> AbstractStat:
	for stat_node in stat_nodes:
		if stat_node.stat_name == stat_name:
			return stat_node
	return null

func _on_pickup_detection_area_entered(area):
	var item_type = area.item_type
	var stat_node : AbstractStat = get_stat_node_by_string_name(item_type)
	stat_node.increase_stat(1)
	item_collected.emit(item_type)

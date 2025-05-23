@icon("uid://n6jp7e16vy1h")
class_name AbstractGameManager
extends Node2D

@export var level_container: Node
@export var player: AbstractPlayer
@export var main_menu: AbstractMenu

var level_map: Dictionary[String, AbstractLevel] = {} 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameStateEvents.LEVEL_CHANGE_REQUESTED.connect(handle_level_change_requested)
	player.get_parent().remove_child(player)

func is_valid_level(levelName: String) -> bool:
	if level_map.has(levelName):
		return true
	var scene: PackedScene = load(levelName)
	if not scene:
		return false
	var level: AbstractLevel = scene.instantiate()
	if level and level is AbstractLevel:
		level_map.set(levelName, level)
		return true
	else:
		return false

func handle_level_change_requested(requestedLevel: String) -> void:
	assert(is_valid_level(requestedLevel), requestedLevel + " is not a valid Level")
	assert(player, "There is no player, we cannot change scenes")
	assert(player is AbstractPlayer, "The player must be of type AbstractPlayer to work with GameManager")
	assert(level_container, "The GameManager is missing a LevelContainer, we cannot proceed")
	var level: AbstractLevel = level_map.get(requestedLevel)
	level.player = player
	if not player.is_inside_tree():
		self.add_child(player)
	_handle_level_transition(level)

func _handle_level_transition(newLevel: AbstractLevel) -> void:
	var level_container_children := level_container.get_children()
	level_container.add_child(newLevel)
	for child in level_container_children:
		child.queue_free()

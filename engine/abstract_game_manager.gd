class_name AbstractGameManager
extends Node2D

@export var level_holder: Node
@export var player: AbstractPlayer

var level_map: Dictionary[String, Level] = {} 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameStateEvents.SCENE_CHANGE_REQUESTED.connect(handle_scene_change_requested)
	

func is_valid_level(levelName: String) -> bool:
	if level_map.has(levelName):
		return true
	var scene: PackedScene = load(levelName)
	if not scene:
		return false
	var level: Level = scene.instantiate()
	if level and level is Level:
		level_map.set(levelName, level)
		return true
	else:
		return false

func handle_scene_change_requested(requestedScene: String) -> void:
	print("Scene change requested to " + requestedScene)
	if is_valid_level(requestedScene):
		print(requestedScene + " is a valid Level")
		var level: Level = level_map.get(requestedScene)
		if not player or player is not AbstractPlayer:
			print("There is no player, we cannot proceed")
			return
		level.player = player
		if not level_holder:
			print("The Level is missing a LevelHolder (of type StaticBody2D), we cannot proceed")
			return
		var existing_level := level_holder.get_children()
		level_holder.add_child(level)
		for child in existing_level:
			child.queue_free()
	else:
		print(requestedScene + " is not a valid Level")

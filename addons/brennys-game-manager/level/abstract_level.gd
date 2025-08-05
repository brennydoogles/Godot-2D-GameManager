@icon("res://addons/brennys-game-manager/icons/AbstractLevel.svg")
class_name AbstractLevel
extends Node2D

@export var player: AbstractPlayer
@export var player_start_location: PlayerTeleportDestination
@export var player_start_override: String

var destination_map: Dictionary[String, Vector2]

func _ready() -> void:
	GameStateEvents.LEVEL_ADDED_TO_TREE.emit()
	map_teleport_destinations()
	if not player_start_location:
		return

	if player:
		if player_start_override:
			assert(destination_map.has(player_start_override), "You can only teleport the player to a registered TeleportDestination")
			GameStateEvents.PLAYER_TELEPORT_REQUESTED.emit(destination_map.get(player_start_override))
		else:
			GameStateEvents.PLAYER_TELEPORT_REQUESTED.emit(player_start_location.global_position)


func _on_tree_exited() -> void:
	GameStateEvents.LEVEL_REMOVED_FROM_TREE.emit()

func _on_tree_entered() -> void:
	GameStateEvents.LEVEL_ADDED_TO_TREE.emit()

func _on_tree_exiting() -> void:
	GameStateEvents.LEVEL_REMOVED_FROM_TREE.emit()


func map_teleport_destinations() -> void:
	for child in self.get_children():
		if child is PlayerTeleportDestination:
			destination_map.set(child.destinationName, child.global_position)

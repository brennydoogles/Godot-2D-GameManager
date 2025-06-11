@icon("uid://bg1slm8h47wey")
class_name AbstractLevel
extends Node2D

@export var player: AbstractPlayer
@export var player_start_location: StaticBody2D
@export var player_start_override: Vector2


func _ready() -> void:
	if player_start_location:
		for child in player_start_location.get_children():
			if child is CollisionShape2D:
				child.disabled = true
		if player:
			if player_start_override:
				GameStateEvents.PLAYER_TELEPORT_REQUESTED.emit(player_start_override)
			else:
				GameStateEvents.PLAYER_TELEPORT_REQUESTED.emit(player_start_location.global_position)

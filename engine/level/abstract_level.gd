@icon("uid://bg1slm8h47wey")
class_name AbstractLevel
extends Node2D

@export var player: AbstractPlayer
@export var player_start_location: StaticBody2D

var player_return_location: StaticBody2D = null


func _ready() -> void:
	if player_start_location:
		for child in player_start_location.get_children():
			if child is CollisionShape2D:
				child.disabled = true
		if player:
			player.visible = false
			player.teleport_to_position(player_start_location.global_position)
			#player.move_and_slide()
			player.visible = true

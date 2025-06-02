@icon("uid://bg1slm8h47wey")
class_name AbstractLevel
extends Node2D

@export var player: AbstractPlayer
@export var player_start_location: StaticBody2D

var player_return_location: StaticBody2D = null


func _ready() -> void:
	if player and player_start_location:
		player.visible = false
		player.teleport_to_position(player_start_location.position)
		player.visible = true

class_name PlayerMovementState
extends Node

@export
var animation_name: String
var parent: Player


func enter() -> void:
	parent.animated_sprite.play(animation_name)

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> PlayerMovementState:
	return null

func process_frame(_delta: float) -> PlayerMovementState:
	return null

func process_physics(_delta: float) -> PlayerMovementState:
	return null

func _get_movement_vector() -> Vector2:
	return Input.get_vector("west", "east", "north", "south")

@icon("uid://d3mdf7txhdw4b")
class_name AbstractPlayer
extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func teleport_to_position(position : Vector2 = Vector2.ZERO) -> void:
	self.position = position # This might need to be self.global_position 

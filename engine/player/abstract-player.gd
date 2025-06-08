@icon("uid://d3mdf7txhdw4b")
class_name AbstractPlayer
extends CharacterBody2D

@export var animated_sprite: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func teleport_to_position(position : Vector2 = Vector2.ZERO) -> void:
	print("Player current position is " + str(self.global_position))
	self.visible = false
	self.animated_sprite.visible = false
	self.global_position = position
	self.animated_sprite.global_position = position
	self.move_and_slide()
	self.visible = true
	self.animated_sprite.visible = true
	print("Player new position is " + str(self.global_position))
	

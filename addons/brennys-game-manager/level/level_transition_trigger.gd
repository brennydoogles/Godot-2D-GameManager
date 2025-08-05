class_name LevelTransitionTrigger
extends Area2D

@export var targetScene: String
@export var teleport_destination: String = "default"
@export var transition_name: String = "fade_to_black"

func _on_body_entered(body: Node2D) -> void:
	if body is AbstractPlayer:
		GameStateEvents.LEVEL_CHANGE_REQUESTED.emit(targetScene, transition_name, teleport_destination)

class_name LevelTransitionTrigger
extends Area2D

@export var targetSceneName: String

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GameStateEvents.SCENE_CHANGE_REQUESTED.emit()

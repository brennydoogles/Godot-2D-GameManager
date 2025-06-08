class_name LevelTransitionTrigger
extends Area2D

@export var targetSceneUid: String


func _ready() -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is AbstractPlayer:
		GameStateEvents.LEVEL_CHANGE_REQUESTED.emit(targetSceneUid)

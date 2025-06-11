class_name LevelTransitionTrigger
extends Area2D

@export var targetSceneUid: String
@export var player_start_override: Vector2


func _ready() -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is AbstractPlayer:
		if player_start_override and player_start_override != Vector2.INF:
			GameStateEvents.LEVEL_CHANGE_WITH_START_POSITION_OVERRIDE_REQUESTED.emit(targetSceneUid, player_start_override)
		else:
			GameStateEvents.LEVEL_CHANGE_REQUESTED.emit(targetSceneUid)

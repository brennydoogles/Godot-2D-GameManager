class_name LevelTransitionTrigger
extends Area2D

@export var targetScene: String
@export var player_start_override: Vector2 = Vector2.INF
@export var transition_name: String = "fade_to_black"


func _ready() -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is AbstractPlayer:
		if player_start_override and player_start_override != Vector2.INF:
			GameStateEvents.LEVEL_CHANGE_WITH_START_POSITION_OVERRIDE_REQUESTED.emit(targetScene, transition_name, player_start_override)
		else:
			GameStateEvents.LEVEL_CHANGE_REQUESTED.emit(targetScene, transition_name)

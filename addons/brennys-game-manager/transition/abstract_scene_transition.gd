class_name AbsctractSceneTransition
extends Control

@export var animation_player: AnimationPlayer
@export var initial_animation_name: String
@export var middle_animation_name: String
@export var final_animation_name: String
var progress: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameStateEvents.LEVEL_VALIDATED.connect(_on_level_validated)
	GameStateEvents.PLAYER_ADDED_TO_LEVEL.connect(_on_player_added_to_level)
	GameStateEvents.LEVEL_ADDED_TO_TREE.connect(_on_level_added_to_tree)
	GameStateEvents.LEVEL_REMOVED_FROM_TREE.connect(_on_level_removed_from_tree)
	GameStateEvents.LEVEL_TRANSITION_COMPLETE.connect(_on_level_transition_complete)
	animation_player.animation_finished.connect(_on_animation_finished)
	self.progress = 0
	if animation_player and initial_animation_name:
		animation_player.play(initial_animation_name)
	GameStateEvents.LEVEL_OUT_TRANSITION_STARTED.emit()

func _on_level_validated() -> void:
	self.progress += 25

func _on_player_added_to_level() -> void:
	self.progress += 25
	if animation_player and middle_animation_name:
		animation_player.play(middle_animation_name)

func _on_level_added_to_tree() -> void:
	self.progress += 25

func _on_level_removed_from_tree() -> void:
	self.progress += 25
	if animation_player and final_animation_name:
		animation_player.play(final_animation_name)
	GameStateEvents.LEVEL_IN_TRANSITION_STARTED.emit()

func _on_level_transition_complete() -> void:
	if animation_player and final_animation_name:
		animation_player.play(final_animation_name)

func _on_animation_finished(animation_name: String) -> void:
	if animation_name == final_animation_name:
		self.queue_free()

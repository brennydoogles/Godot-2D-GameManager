## This script provides base functionality for the whole library.
@icon("uid://n6jp7e16vy1h")
class_name AbstractGameManager
extends Node2D

## A node container for levels that are loaded into the scene
@export var level_container: Node
@export var menu_container: Node
@export var transition_container: Node
@export var player: AbstractPlayer
@export var main_menu: String
@export var levels: Array[LevelKey]
@export var menus: Array[MenuKey]
@export var transitions: Array[TransitionKey]

var level_map: Dictionary[String, PackedScene] = {}
var menu_map: Dictionary[String, PackedScene] = {}
var transition_map: Dictionary[String, PackedScene] = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect_signals()
	prep_player()
	map_menus()
	map_levels()
	map_transitions()
	GameStateEvents.SHOW_MENU_REQUESTED.emit(main_menu)

func connect_signals() -> void:
	GameStateEvents.LEVEL_CHANGE_REQUESTED.connect(handle_level_change_requested)
	GameStateEvents.LEVEL_CHANGE_WITH_START_POSITION_OVERRIDE_REQUESTED.connect(handle_level_change_with_start_position_override_requested)
	GameStateEvents.SHOW_MENU_REQUESTED.connect(handle_show_menu_request)
	GameStateEvents.CLOSE_MENU_REQUESTED.connect(handle_close_menu_request)

func prep_player() -> void:
	player.get_parent().remove_child(player)

func map_menus() -> void:
	for menu in menus:
		assert(menu.targetScene.instantiate() is AbstractMenu, "Only Scenes which inherit from AbstractMenu can be registered as a menu")
		menu_map.set(menu.menuName, menu.targetScene)

func map_levels() -> void:
	for level in levels:
		assert(level.targetScene.instantiate() is AbstractLevel, "Only Scenes which inherit from AbstractLevel can be registered as a level")
		level_map.set(level.levelName, level.targetScene)

func map_transitions() -> void:
	for transition in transitions:
		assert(transition.targetScene.instantiate() is AbsctractSceneTransition, "Only Scenes which inherit from AbstractSceneTransition can be registered as a Scene Transition")
		transition_map.set(transition.transitionName, transition.targetScene)

func handle_show_menu_request(requestedMenu: String) -> void:
	assert(is_valid_menu(requestedMenu), requestedMenu + " is not a valid Menu")
	var menu : AbstractMenu = menu_map.get(requestedMenu).instantiate()
	self.call_deferred("_handle_menu_transition", menu)

func handle_close_menu_request() -> void:
	var menu_container_children := menu_container.get_children()
	for child in menu_container_children:
		child.queue_free()
	GameStateEvents.MENU_CLOSED.emit()

func is_valid_menu(requestedMenu: String) -> bool:
	return menu_map.has(requestedMenu)

func _handle_menu_transition(newMenu: AbstractMenu) -> void:
	var menu_container_children := menu_container.get_children()
	menu_container.call_deferred("add_child", newMenu)
	for child in menu_container_children:
		child.queue_free()

func handle_level_change_requested(requestedLevel: String, requestedTransition: String) -> void:
	
	change_level(requestedLevel, requestedTransition, Vector2.INF)

func handle_level_change_with_start_position_override_requested(requestedLevel: String, requestedTransition: String, player_start_override: Vector2) -> void:
	change_level(requestedLevel, requestedTransition, player_start_override)

func is_valid_level(levelName: String) -> bool:
	return level_map.has(levelName)

func change_level(requestedLevel: String, requestedTransition: String, player_start_override: Vector2) -> void:
	if transition_container and requestedTransition and transition_map.has(requestedTransition):
		var transition: AbsctractSceneTransition = transition_map.get(requestedTransition).instantiate()
		transition_container.add_child(transition)
	assert(is_valid_level(requestedLevel), requestedLevel + " is not a valid Level")
	assert(player, "There is no player, we cannot change scenes")
	assert(player is AbstractPlayer, "The player must be of type AbstractPlayer to work with GameManager")
	assert(level_container, "The GameManager is missing a LevelContainer, we cannot proceed")
	var level: AbstractLevel = level_map.get(requestedLevel).instantiate()
	assert(level is AbstractLevel, "The Loaded Level must be of type AbstractLevel to work with GameManager")
	GameStateEvents.LEVEL_VALIDATED.emit()
	if player_start_override and player_start_override != Vector2.INF:
		level.player_start_override = player_start_override
	level.player = player
	GameStateEvents.PLAYER_ADDED_TO_LEVEL.emit()
	if not player.is_inside_tree():
		self.add_child(player)
	self.call_deferred("_handle_level_transition", level)

func _handle_level_transition(newLevel: AbstractLevel) -> void:
	var level_container_children := level_container.get_children()
	level_container.call_deferred("add_child", newLevel)
	for child in level_container_children:
		child.queue_free()
	GameStateEvents.LEVEL_TRANSITION_COMPLETE.emit()

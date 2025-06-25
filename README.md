# Godot 2D GameManager
This project aims to create a loosely coupled game manager for managing scene and menu transitions for 2D Godot games. It is currently in EARLY DEVELOPMENT, and is not yet ready for use in projects. If you want to help change that feel free to contribute!


## NOTE: This README is under active development and is not currently complete. It should be finished within a few days.

## Project Structure
The project is currently structured with two primary folders in the repository root. 
### Overview

#### Engine
This folder holds the main implementation of the GameManager engine. The classes and scenes in this folder should be safe to drop into any project and use without fear of any missing dependencies.
#### Demo Game
This folder contains a demo-game which will (as development progresses) hold a small game which implements all of the features supported by the game manager engine. This is accomplished by extending the base classes of the GameManager engine and emitting the proper signals in order to evoke Gamemanager functionality.

### Engine Base Classes

#### Game Manager

##### AbstractGameManager
This class is the star of the show. AbstractGameManager provides the base functionality for the whole library. It currently requires two export vars to be set in order function. These are:
* Level Container: Node
    * Level Container is the Node that the GameManager will load all new Level scenes into.
* Menu Container: Node
    * Menu Container is the Node that the GameManager will load all new Menu scenes into.
* Transition Container: Node
    * Transition Container is the Node that the GameManager will load all new Transition scenes into.
* Player: AbstractPlayer
    * Player represents the player object which will be added to each scene when it loads.
* Levels: Array\[LevelKey\]
    * This variable holds an array of LevelKey resources, which allows the developer to register all possible Level Scenes with the Game Manager in association with a String key which can be used to reference that Level when requesting to load it.
* Menus: Array\[MenuKey\]
    * This variable holds an array of MenuKey resources, which allows the developer to register all possible Menu Scenes with the Game Manager in association with a String key which can be used to reference that Menu when requesting to load it.
* Transitions: Array\[TransitionKey\]
    * This variable holds an array of TransitionKey resources, which allows the developer to register all possible Transition Scenes with the Game Manager in association with a String key which can be used to reference that Transition when requesting to use it.
* Main Menu: String
    * The String key of the Main Menu the developer would like the GameManager to load once it is ready. Note, this will only work if the String is defined in a valid MenuKey.

#### Player
##### AbstractPlayer
This class is the base class representing a player. It extends from CharacterBody2D and has no child nodes by default. 

#### Level

##### LevelKey
This Resource class provides a simple mapping between a Scene and a user friendly String levelName. The purpose of this class is to inform the GameManager of all valid levels and their names. It has the following export vars:
 * levelName: String
	 * The String by which this level will be referenced when loading.
 * targetScene: PackedScene
	 * The actual Scene to load. Note: This scene MUST descend from AbstractLevel, or the GameManager will throw an error during loading.

##### AbstractLevel
This is the base class for all levels, and extends Node2D. The AbstractLevel class requires two export vars to be set in order to function properly. These are:
* player: AbstractPlayer
	* This is the player to be added to the level. Before loading the level (just prior to adding the level to the scene tree), the player var from the AbstractGameManager will be injected into the level.
* player_start_location: StaticBody2D
	* This is the location the player should be teleported to when entering the level under normal conditions. 
* player_start_override: Vector2
	* This is an optional location the player should be teleported to instead of the normal player_start_location.  The developer should never need to manually set this value.

##### LevelTransitionTrigger
This node, which extends Area2D, can be placed in a Level anywhere the developer wants to trigger the transition to another level (a CollisionShape2D must be provided as a child node in order to actually collide). The LevelTransitionTrigger requires the following export vars to be set in order to function:
 * targetScene: String
	 * The Level key configured for the level you want to load upon colliding with this trigger.
 * player_start_override: Vector2
	 * This optional var holds the position within the scene the player should be teleported to. If no value is set, the level's default player start location will be used.
 * transition_name: String
	 * This optional var holds the name of the transition to use when moving to the next scene. If no value is provided, the default value is "fade_to_black".
#### Menu 
##### AbstractMenu
This is the base class for all Menus, and it extends from Control. Currently this class is not used for anything, but I intend for Menus to be loadable as overlays, and for various improvements in the loading of the initial Main Menu to be implemented this way (for example, the MainMenu of the Demo Game is currently zoomed in too much because of the Player's camera zoom. Once I have a method for loading menus I can disable this camera or potentially remove the player from the scene tree while the menu is on screen).

#### Transition
#####  AbstractSceneTransition
#### GameStateEvents
This script, which extends Node (and will probably be renamed to AbstractGameStateEvents), is an Autoloaded script which defines all of the signals the AbstractGameManager will handle or emit.

### Game Manager Signals
The following signals may be emitted or connected to in order to work with the Game Manager.

#### LEVEL_CHANGE_REQUESTED(requestedLevel: String)
This signal may be emitted at any point to request that the GameManager change the active Level to any other Level. It will first verify that the requested scene exists and is of a type which descends from AbstractLevel, before passing in the player and loading the scene. Where possible it is recommended to use the UID of a scene rather than its path to allow easier refactoring of the project.

#### LEVEL_CHANGE_WITH_START_POSITION_OVERRIDE_REQUESTED(requestedLevel: String, player_start_override: Vector2)
This signal may be emitted at any point to request that the GameManager change the active Level to any other Level, while providing an override to the Level's default player start location. It will first verify that the requested scene exists and is of a type which descends from AbstractLevel, before passing in the player and loading the scene. Where possible it is recommended to use the UID of a scene rather than its path to allow easier refactoring of the project.

#### PLAYER_TELEPORT_REQUESTED(toLocation: Vector2)
This signal will be emitted by the AbstractLevel upon load, in order for the Player scene to know to teleport to the new location. This is not automatically handled by the GameManager classes since the individual game's movement logic may have considerations to take into account during the teleportation process.
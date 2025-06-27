# Godot 2D GameManager
This project aims to create a loosely coupled game manager for managing scene and menu transitions for 2D Godot games. It is currently in EARLY DEVELOPMENT, and is not yet ready for use in projects. If you want to help change that feel free to contribute!


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

##### MenuKey
This Resource class provides a simple mapping between a Scene and a user friendly String menuName. The purpose of this class is to inform the GameManager of all valid menus and their names. It has the following export vars:
 * menuName: String
	 * The String by which this menu will be referenced when loading.
 * targetScene: PackedScene
	 * The actual Scene to load. Note: This scene MUST descend from AbstractMenu, or the GameManager will throw an error during loading.
##### AbstractMenu
This is the base class for all Menus, and it extends from Control. It has no child nodes, and upon entering the scene tree it emits the MENU_OPEN signal from GameStateEvents

#### Transition

##### TransitionKey
This Resource class provides a simple mapping between a Scene and a user friendly String transitionName. The purpose of this class is to inform the GameManager of all valid transitions and their names. It has the following export vars:
 * transitionName: String
	 * The String by which this transition will be referenced when loading.
 * targetScene: PackedScene
	 * The actual Scene to load. Note: This scene MUST descend from AbstractSceneTransition, or the GameManager will throw an error during loading.
#####  AbstractSceneTransition
This is the base class for all Scene Transitions, and it extends from Control. AbstractSceneTransition has the following export vars:
 * animation_player: AnimationPlayer
	 * This variable holds a reference to the AnimationPlayer which is configured with the animations for this transition.
 * initial_animation_name: String
	 * This variable holds the animation name to play when leaving the current scene.
 * middle_animation_name: String
	 * This variable holds the animation name to play after the initial animation has finished and while waiting for the new Scene to be loaded.
 * final_animation_name: String
	 * This variable holds the animation to play when revealing the new scene.


#### GameStateEvents
This script, which extends Node, is an Autoloaded script which defines all of the signals the AbstractGameManager will handle or emit. These signals are as follows:

  ##### SHOW_MENU_REQUESTED(requestedMenu: String) 
This signal informs the GameManager that the game would like to show a menu in the MenuContainer. The single parameter, requestedMenu, should correspond with the menuName of a MenuKey which has been registered with the GameManager

 ##### CLOSE_MENU_REQUESTED 
This signal informs the GameManager that the game would like to close any currently open Menus.

 ##### MENU_OPEN 
This signal will be emitted by the GameManager whenever a Menu has been opened.

 ##### MENU_CLOSED 
This signal will be emitted by the GameManager whenever a Menu has been closed.

 ##### LEVEL_CHANGE_REQUESTED(requestedLevel: String, requestedTransition: String) 
This signal informs the GameManager that the game would like to load a new level in the LevelContainer with a specified transition. The first parameter, requestedLevel, should correspond with the levelName of a LevelKey which has been registered with the GameManager. The second parameter, requestedTransition, should correspond with the transitionName of a TransitionKey which has been registered with the GameManager.

 ##### LEVEL_CHANGE_WITH_START_POSITION_OVERRIDE_REQUESTED(requestedLevel: String, requestedTransition: String, player_start_override: Vector2) 
This signal informs the GameManager that the game would like to load a new level in the LevelContainer with a specified transition, and place the player in a position other than the default player start location for that level. The first parameter, requestedLevel, should correspond with the levelName of a LevelKey which has been registered with the GameManager. The second parameter, requestedTransition, should correspond with the transitionName of a TransitionKey which has been registered with the GameManager. The third parameter, player_start_override, is the Vector2 position where the player should be teleported during the level transition.

 ##### LEVEL_VALIDATED 
This signal will be emitted by the GameManager during the level transition process whenever the requested level has been validated to exist and be of the correct type.

 ##### PLAYER_ADDED_TO_LEVEL 
This signal will be emitted by the GameManager during the level transition process when the Player has been successfully added to the new level scene.

 ##### LEVEL_ADDED_TO_TREE 
This signal will be emitted by the GameManager during the level transition process whenever the requested level has been added to the scene tree.

 ##### LEVEL_REMOVED_FROM_TREE 
This signal will be emitted by the GameManager during the level transition process whenever the previous level has been removed from the scene tree.

 ##### LEVEL_OUT_TRANSITION_STARTED 
This signal will be emitted by the GameManager whenever the transition from the old level has started.

 ##### LEVEL_IN_TRANSITION_STARTED 
This signal will be emitted by the GameManager whenever the transition to the new level has started.

 ##### LEVEL_TRANSITION_COMPLETE 
This signal will be emitted by the GameManager whenever the transition between levels is complete.

 ##### PLAYER_TELEPORT_REQUESTED(toLocation: Vector2) 
This signal will be emitted by the GameManager in order to request that the player be teleported to a new location. The first parameter, toLocation, represents the location the player should be teleported to. *Note: The game developer must handle this signal in their game logic in order for the GameManager to function correctly*. This will allow the Game developer to handle any custom movement mechanics or state that may have been implemented in their game.


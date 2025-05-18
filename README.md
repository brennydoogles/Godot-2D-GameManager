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

#### AbstractGameManager
This class is the star of the show. AbstractGameManager provides the base functionality for the whole library. It currently requires two export vars to be set in order function. These are:
 * level_holder: Node
 	* Level Holder is the Node that the GameManager wants all new Level scenes loaded into.
 * player: AbstractPlayer
 	* Player represents the player object which will be added to each scene when it loads

#### AbstractPlayer
This class is the base class representing a player. It extends from CharacterBody2D and has no child nodes by default. The only exposed functionality of this class is a 'teleport_to_position(location: Vector2)' function to teleport the player to a particular location, which is called by each Level in order to position the player in the correct spot when the Level is loaded.

#### AbstractLevel
This is the base class for all levels, and extends Node2D. The AbstractLevel class requires two export vars to be set in order to function properly. These are:
 * player: AbstractPlayer
 	* This is the player to be added to the level. Before loading the level (just prior to adding the level to the scene tree), the player var from the AbstractGameManager will be injected into the level.
 * player_start_location: StaticBody2D
 	* This is the location the player should be teleported to when entering the level under normal conditions. In the _ready() function of the AbstractLevel the player's teleport_to_position() function is passed the location of this StaticBody2D


#### AbstractMenu
This is the base class for all Menus, and it extends from Control. Currently this class is not used for anything, but I intend for Menus to be loadable as overlays, and for various improvements in the loading of the initial Main Menu to be implemented this way (for example, the MainMenu of the Demo Game is currently zoomed in too much because of the Player's camera zoom. Once I have a method for loading menus I can disable this camera or potentially remove the player from the scene tree while the menu is on screen).

#### GameStateEvents
This script, which extends Node (and will probably be renamed to AbstractGameStateEvents), is an Autoloaded script which defines all of the signals the AbstractGameManager will handle or emit.

### Game Manager Signals
The following signals may be emitted or called in order to work with the Game Manager.

#### SCENE_CHANGE_REQUESTED(requestedScene: String)
This signal may be emitted at any point to request that the GameManager change the active scene to any other scene. It will first verify that the requested scene exists and is of a type which descends from AbstractLevel, before passing in the player and loading the scene.

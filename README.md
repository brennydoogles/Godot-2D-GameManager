# Godot 2D GameManager

This project aims to create a loosely coupled game manager for managing scene and menu transitions for 2D Godot games. It is currently in EARLY DEVELOPMENT, and is not yet ready for use in projects. If you want to help change that feel free to contribute!

## Project Structure
The project is currently structured with two primary folders in the repository root. 
### engine
This folder holds the main implementation of the GameManager engine. The classes and scenes in this folder should be safe to drop into any project and use without fear of any missing dependencies.
### demo-game
This folder contains a demo-game which will (as development progresses) hold a small game which implements all of the features supported by the game manager engine. This is accomplished by extending the base classes of the GameManager engine and emitting the proper signals in order to evoke Gamemanager functionality.

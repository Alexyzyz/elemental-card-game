class_name LoadManager
extends Node

static var audio: LoadManagerAudio
static var prefabs: LoadManagerPrefabs
static var scenes: LoadManagerScenes

# Main methods

func set_up():
	audio = $Audio
	prefabs = $Prefabs
	scenes = $Scenes
	
	prefabs.set_up()
	scenes.set_up()

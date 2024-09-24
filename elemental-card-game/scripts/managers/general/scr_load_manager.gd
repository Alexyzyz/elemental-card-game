class_name LoadManager
extends Node

static var audio: LoadManagerAudio
static var prefabs: LoadManagerPrefabs
static var scenes: LoadManagerScenes
static var misc: LoadManagerMisc

# Main methods

func set_up():
	audio = $Audio
	prefabs = $Prefabs
	scenes = $Scenes
	misc = $Misc
	
	prefabs.set_up()
	scenes.set_up()
	misc.set_up()

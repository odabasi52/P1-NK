extends Node

@export var level_scenes: Array[PackedScene]
var current_level_index = 0

func next_level():
	current_level_index += 1
	change_scene(current_level_index)

func current_level():
	change_scene(current_level_index)

func change_scene(scene_index):
	var next_scene = null
	
	if scene_index >= level_scenes.size():
		next_scene = 0
	else:
		next_scene = scene_index
	
	$"/root/ScreenTransitionManager".transition_to_scene(level_scenes[next_scene].resource_path)

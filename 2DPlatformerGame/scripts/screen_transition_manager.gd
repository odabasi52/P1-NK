extends Node

var screen_transition = preload("res://scenes/UI/screen_transitions.tscn")

func transition_to_scene(scenePath):
	var screen_transition_instance = screen_transition.instantiate()
	add_child(screen_transition_instance)
	await screen_transition_instance.screen_covered
	get_tree().change_scene_to_file(scenePath)

func transition_to_menu():
	transition_to_scene("res://scenes/UI/main_menu.tscn")

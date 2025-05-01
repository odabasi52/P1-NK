extends Node2D

@export var tutorial_text: String

func _ready() -> void:
	$PanelContainer/MarginContainer/Label.text = tutorial_text
	$PanelContainer.visible = false
	
	$Area2D.connect("area_entered", Callable(self, "on_area_entered"))
	$Area2D.connect("area_exited", Callable(self, "on_area_exited"))
	
func on_area_entered(area2d):
	$PanelContainer.visible = true
	$Sprite2D.frame = 1

func on_area_exited(area2d):
	$PanelContainer.visible = false 
	$Sprite2D.frame = 0

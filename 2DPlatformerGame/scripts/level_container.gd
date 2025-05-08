extends MarginContainer

@export var labelText: String
@export var texture: Texture
@export var levelNumber: int
@onready var label: Label = $MarginContainer/VBoxContainer/Label
@onready var panel: Panel = $Panel
@onready var texture_rect: TextureRect = $MarginContainer/VBoxContainer/TextureRect

func _ready() -> void:
	panel.visible = false
	label.text = labelText
	texture_rect.texture = texture

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("MouseClicked") and panel.visible:
		on_click()

func _on_mouse_entered() -> void:
	panel.visible = true

func _on_mouse_exited() -> void:
	panel.visible = false

func on_click() -> void:
	$"/root/LevelManager".change_scene(levelNumber)
	$"/root/MouseCursor".visible = false

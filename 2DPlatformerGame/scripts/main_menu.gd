extends CanvasLayer

@onready var play_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/PlayButton
@onready var setting_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/SettingButton
@onready var exit_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ExitButton

func _ready() -> void:
	play_button.connect("pressed", Callable(self, "on_play_pressed"))
	exit_button.connect("pressed", Callable(self, "on_exit_pressed"))

func on_play_pressed():
	$"/root/LevelManager".change_scene(0)
	
func on_exit_pressed():
	get_tree().quit()

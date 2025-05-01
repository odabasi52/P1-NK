extends CanvasLayer

@onready var play_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/PlayButton
@onready var setting_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/SettingButton
@onready var exit_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ExitButton

var settings_menu = preload("res://scenes/UI/settings_menu.tscn")

func _ready() -> void:
	play_button.connect("pressed", Callable(self, "on_play_pressed"))
	exit_button.connect("pressed", Callable(self, "on_exit_pressed"))
	setting_button.connect("pressed", Callable(self, "on_settings_pressed"))

func on_play_pressed():
	$"/root/LevelManager".change_scene(0)
	$"/root/MouseCursor".visible = false
	
func on_exit_pressed():
	get_tree().quit()
	
func on_settings_back_pressed():
	if $SettingsMenu:
		$SettingsMenu.queue_free()
		$MarginContainer.visible = true

func on_settings_pressed():
	$MarginContainer.visible = false
	var settings_menu_instance = settings_menu.instantiate()
	add_child(settings_menu_instance)
	settings_menu_instance.connect("back_pressed", Callable(self, "on_settings_back_pressed"))

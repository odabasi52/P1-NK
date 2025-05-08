extends CanvasLayer

@onready var play_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/PlayButton
@onready var levelSelection_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ChangeLevelButton
@onready var setting_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/SettingButton
@onready var exit_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ExitButton

var settings_menu = preload("res://scenes/UI/settings_menu.tscn")
var level_menu = preload("res://scenes/UI/levelselection_menu.tscn")

func _ready() -> void:
	play_button.connect("pressed", Callable(self, "on_play_pressed"))
	levelSelection_button.connect("pressed", Callable(self, "on_levelSelection_pressed"))
	exit_button.connect("pressed", Callable(self, "on_exit_pressed"))
	setting_button.connect("pressed", Callable(self, "on_settings_pressed"))

func on_levelSelection_pressed():
	await get_tree().create_timer(0.1).timeout
	$MarginContainer.visible = false
	var level_menu_instance = level_menu.instantiate()
	add_child(level_menu_instance)
	level_menu_instance.connect("back_pressed", Callable(self, "on_levelSelection_back_pressed"))

func on_levelSelection_back_pressed():
	await get_tree().create_timer(0.1).timeout
	if $LevelSelection:
		$LevelSelection.queue_free()
		$MarginContainer.visible = true

func on_play_pressed():
	await get_tree().create_timer(0.1).timeout
	$"/root/LevelManager".change_scene(0)
	$"/root/MouseCursor".visible = false
	
func on_exit_pressed():
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()
	
func on_settings_back_pressed():
	await get_tree().create_timer(0.1).timeout
	if $SettingsMenu:
		$SettingsMenu.queue_free()
		$MarginContainer.visible = true

func on_settings_pressed():
	await get_tree().create_timer(0.1).timeout
	$MarginContainer.visible = false
	var settings_menu_instance = settings_menu.instantiate()
	add_child(settings_menu_instance)
	settings_menu_instance.connect("back_pressed", Callable(self, "on_settings_back_pressed"))

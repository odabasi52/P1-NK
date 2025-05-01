extends CanvasLayer

@onready var continue_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ContinueButton
@onready var setting_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/SettingButton
@onready var exit_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ExitButton

var settings_menu = preload("res://scenes/UI/settings_menu.tscn")

func _ready() -> void:
	continue_button.connect("pressed", Callable(self, "on_continue_pressed"))
	setting_button.connect("pressed", Callable(self, "on_settings_pressed"))
	exit_button.connect("pressed", Callable(self, "on_exit_pressed"))
	get_tree().paused = true
	$"/root/MouseCursor".visible = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		unpause()
		get_viewport().set_input_as_handled()
		$"/root/MouseCursor".visible = false

func unpause():
	queue_free()
	get_tree().paused = false

func on_continue_pressed():
	unpause()
	$"/root/MouseCursor".visible = false
	
func on_settings_pressed():
	$MarginContainer.visible = false
	var settings_menu_instance = settings_menu.instantiate()
	add_child(settings_menu_instance)
	settings_menu_instance.connect("back_pressed", Callable(self, "on_settings_back_pressed"))

func on_settings_back_pressed():
	if $SettingsMenu:
		$SettingsMenu.queue_free()
		$MarginContainer.visible = true

func on_exit_pressed():
	$"/root/ScreenTransitionManager".transition_to_menu()
	unpause()

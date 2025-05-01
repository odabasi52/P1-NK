extends CanvasLayer

@onready var continue_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ContinueButton
@onready var setting_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/SettingButton
@onready var exit_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ExitButton

func _ready() -> void:
	continue_button.connect("pressed", Callable(self, "on_continue_pressed"))
	setting_button.connect("pressed", Callable(self, "on_settings_pressed"))
	exit_button.connect("pressed", Callable(self, "on_exit_pressed"))
	get_tree().paused = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		unpause()
		get_viewport().set_input_as_handled()

func unpause():
	queue_free()
	get_tree().paused = false

func on_continue_pressed():
	unpause()
	
func on_settings_pressed():
	pass
	
func on_exit_pressed():
	$"/root/ScreenTransitionManager".transition_to_menu()
	unpause()

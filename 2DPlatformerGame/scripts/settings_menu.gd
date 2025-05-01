extends CanvasLayer

@onready var back_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/BackButton
@onready var window_mode_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/WindowModeButton

signal back_pressed

func _ready() -> void:
	window_mode_button.connect("pressed", Callable(self, "on_window_mode_pressed"))
	back_button.connect("pressed", Callable(self, "on_back_pressed"))
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		window_mode_button.text = "FULLSCREEN"
	else: window_mode_button.text = "WINDOWED"
	
func update_display():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		window_mode_button.text = "FULLSCREEN"
	else: window_mode_button.text = "WINDOWED"
	
func on_back_pressed():
	emit_signal("back_pressed")
	
func on_window_mode_pressed():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else: 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	update_display()

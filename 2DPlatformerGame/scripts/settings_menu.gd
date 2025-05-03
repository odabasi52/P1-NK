extends CanvasLayer

@onready var back_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/BackButton
@onready var window_mode_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/WindowModeButton

signal back_pressed
@onready var music_range_container: HBoxContainer = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/MusicContainer/MusicRangeContainer
@onready var sfx_range_container: HBoxContainer = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/SFXContainer/SFXRangeContainer

func _ready() -> void:
	window_mode_button.connect("pressed", Callable(self, "on_window_mode_pressed"))
	back_button.connect("pressed", Callable(self, "on_back_pressed"))
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		window_mode_button.text = "FULLSCREEN"
	else: window_mode_button.text = "WINDOWED"
	
	music_range_container.connect("percentage_changed", Callable(self, "on_music_changed"))
	sfx_range_container.connect("percentage_changed", Callable(self, "on_sfx_changed"))
	update_initial_volume_settings()

func update_initial_volume_settings():
	var idx = AudioServer.get_bus_index("Music")
	var volumePercent = db_to_linear(AudioServer.get_bus_volume_db(idx))
	music_range_container.set_current_percent(volumePercent)	
	
	idx = AudioServer.get_bus_index("SFX")
	volumePercent = db_to_linear(AudioServer.get_bus_volume_db(idx))
	sfx_range_container.set_current_percent(volumePercent)	
	
func update_volume(bus, percent):
	var busIdx = AudioServer.get_bus_index(bus)
	var volDb = linear_to_db(percent)
	AudioServer.set_bus_volume_db(busIdx, volDb)

func on_music_changed(percent):
	update_volume("Music", percent)
	
func on_sfx_changed(percent):
	update_volume("SFX", percent)

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

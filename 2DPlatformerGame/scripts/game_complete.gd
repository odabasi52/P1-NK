extends CanvasLayer

@onready var exit_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ExitButton

func _ready() -> void:
	exit_button.connect("pressed", Callable(self, "on_exit_pressed"))

func on_exit_pressed():
	$"/root/ScreenTransitionManager".transition_to_menu()

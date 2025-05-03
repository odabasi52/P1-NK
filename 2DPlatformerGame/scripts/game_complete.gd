extends CanvasLayer

@onready var exit_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ExitButton

func _ready() -> void:
	exit_button.connect("pressed", Callable(self, "on_exit_pressed"))
	$"/root/MouseCursor".visible = true
	
func on_exit_pressed():
	await get_tree().create_timer(0.1).timeout
	$"/root/ScreenTransitionManager".transition_to_menu()

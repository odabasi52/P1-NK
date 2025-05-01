extends CanvasLayer

@onready var next_level_button: Button = $PanelContainer/MarginContainer/VBoxContainer/NextLevelButton
@onready var exit_button: Button = $PanelContainer/MarginContainer/VBoxContainer/ExitButton

func _ready():
	next_level_button.pressed.connect(self.on_pressed)
	exit_button.pressed.connect(self.on_exit_pressed)
	
func on_pressed():
	$"/root/LevelManager".next_level()

func on_exit_pressed():
	$"/root/ScreenTransitionManager".transition_to_menu()

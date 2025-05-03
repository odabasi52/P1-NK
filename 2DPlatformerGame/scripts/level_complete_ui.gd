extends CanvasLayer

@onready var next_level_button: Button = $PanelContainer/MarginContainer/VBoxContainer/NextLevelButton
@onready var exit_button: Button = $PanelContainer/MarginContainer/VBoxContainer/ExitButton
@onready var restart_button: Button = $PanelContainer/MarginContainer/VBoxContainer/RestartButton

func _ready():
	next_level_button.pressed.connect(self.on_pressed)
	exit_button.pressed.connect(self.on_exit_pressed)
	restart_button.pressed.connect(self.on_restart_pressed)
	$"/root/MouseCursor".visible = true
	
func on_pressed():
	await get_tree().create_timer(0.1).timeout
	$"/root/MouseCursor".visible = false
	$"/root/LevelManager".next_level()

func on_exit_pressed():
	await get_tree().create_timer(0.1).timeout
	$"/root/ScreenTransitionManager".transition_to_menu()

func on_restart_pressed():
	await get_tree().create_timer(0.1).timeout
	$"/root/MouseCursor".visible = false
	$"/root/LevelManager".current_level()

extends CanvasLayer

@onready var back_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/MarginContainer2/BackButton


signal back_pressed

func _ready() -> void:
	back_button.connect("pressed", Callable(self, "on_back_pressed"))

func on_back_pressed():
	emit_signal("back_pressed")

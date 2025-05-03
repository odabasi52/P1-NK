extends Button

@export var disableHover: bool = false

func _ready() -> void:
	connect("mouse_entered", Callable(self, "on_mouse_entered"))
	connect("mouse_exited", Callable(self, "on_mouse_exited"))
	connect("pressed", Callable(self, "on_pressed"))

func _process(delta: float) -> void:
	pivot_offset = custom_minimum_size / 2

func on_pressed():
	$AudioStreamPlayer.play()
	$AnimationPlayer.play("click")

func on_mouse_entered():
	if not disableHover:
		$AnimationPlayer.play("hover")

func on_mouse_exited():
	if not disableHover:
		$AnimationPlayer.play_backwards("hover")

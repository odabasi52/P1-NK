extends CanvasLayer

func _ready() -> void:
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)

func _process(delta: float) -> void:
	$Sprite2D.global_position = $Sprite2D.get_global_mouse_position()
	if Input.is_action_just_pressed("MouseClicked"):
		$AnimationPlayer.play("click")
			

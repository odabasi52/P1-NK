extends HBoxContainer

var currentPercentage = 1.0
signal percentage_changed

func _ready() -> void:
	$MinusButton.custom_minimum_size = Vector2(30, 0)
	$PlusButton.custom_minimum_size = Vector2(30, 0)
	
	$MinusButton.connect("pressed", Callable(self, "on_minus_pressed"))
	$PlusButton.connect("pressed", Callable(self, "on_plus_pressed"))

func set_current_percent(percent):
	currentPercentage = clamp(percent, 0, 1)
	$Label.text = str(int(round(currentPercentage * 10)))
	emit_signal("percentage_changed", currentPercentage)

func on_minus_pressed():
	set_current_percent(currentPercentage - 0.1)
	
func on_plus_pressed():
	set_current_percent(currentPercentage + 0.1)

extends Node2D

signal player_won

func _ready():
	$Area2D.area_entered.connect(self.on_win)


func on_win(area2d):
	$RandomAudioStreamPlayer.play()
	$AudioStreamPlayer.play()
	emit_signal("player_won")
	$"/root/Helpers".apply_camera_shake(0.6)
	$GPUParticles2D.emitting = true

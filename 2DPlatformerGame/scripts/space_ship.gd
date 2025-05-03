extends Node2D

signal game_finished

func _ready():
	$Area2D.area_entered.connect(self.on_finish)


func on_finish(area2d):
	$RandomAudioStreamPlayer.play()
	$AudioStreamPlayer.play()
	emit_signal("game_finished")
	$"/root/Helpers".apply_camera_shake(0.6)
	$GPUParticles2D.emitting = true

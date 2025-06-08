extends CharacterBody2D

var playerDeath = preload("res://scenes/player_death.tscn")
var footStepParticles = preload("res://scenes/foot_step_particles.tscn")

enum State{NORMAL, DASHING, INPUT_DISABLED}
signal died
var gravity = 1500
var maxSpeed = 120
var jumpSpeed = 420
var maxDashSpeed = 600
var minDashSpeed = 200
var horizontalAcceleration = 1500
var jumpTerminationMultiplier = 4
var hasDoubleJump = false
var hasDash = false
var currentState = State.NORMAL
var stateChanged = false
var isDying = false
var isStateNew = true

func _ready():
	$DyingArea.area_entered.connect(self.on_spike_entered)
	$Yapıs.area_entered.connect(self.on_yapıs_entered)
	$Yapısma.area_exited.connect(self.on_yapıs_exited)
	$"Zıpla".area_entered.connect(self.on_zıpla_entered)
	
	
	
	
	$AnimatedSprite2D.connect("frame_changed", Callable(self, "on_animated_sprite_frame_changed"))	
	#spike dying area
	$DyingArea.set_collision_mask_value(31, true)
	$Yapıs.set_collision_mask_value(4, true)
	$Yapısma.set_collision_mask_value(5, true)
	$DashArea/CollisionShape2D.disabled = true

func _process(delta):
	match currentState:
		State.NORMAL:
			state_normal(delta)
		State.DASHING:
			state_dashing(delta)
		State.INPUT_DISABLED:
			state_disabled(delta)
	stateChanged = false
	
func state_disabled(delta):
	if (!isStateNew):
		$AnimatedSprite2D.play("idle")
	velocity.x = lerpf(0, velocity.x, pow(2, -30*delta))
	velocity.y += gravity * delta
	move_and_slide()

func change_state(newState):
	currentState = newState
	stateChanged = true

func state_dashing(delta):
	var veloMod = 1 if $AnimatedSprite2D.flip_h else -1
	
	if stateChanged:
		$DashAudioPlayer.play()
		$DashParticle.emitting = true
		$"/root/Helpers".apply_camera_shake(0.75)
		velocity = Vector2(maxDashSpeed*veloMod, 0)
		$DashArea.get_node("CollisionShape2D").disabled = false
		$DyingArea.set_collision_mask_value(31, false)
		
	velocity.x = lerpf(0, velocity.x, pow(2, -8*delta))
	move_and_slide()
	
	if abs(velocity.x) <= minDashSpeed:
		call_deferred("change_state", State.NORMAL)
		$DashArea.get_node("CollisionShape2D").disabled = true
		$DyingArea.set_collision_mask_value(31, true)
		
func state_normal(delta):	
	$DashParticle.emitting = false
	var moveVector = get_move_vector()		
	
	velocity.x += moveVector.x * horizontalAcceleration*delta
	if moveVector.x == 0:
		velocity.x = lerpf(0, velocity.x, pow(2, -30*delta))
		
	#restrict max speed
	velocity.x = clamp(velocity.x, -maxSpeed, maxSpeed)
	
	if moveVector.y < 0 and (is_on_floor() or !$CoyoteTimer.is_stopped() or hasDoubleJump):
		velocity.y = moveVector.y * jumpSpeed
		if not is_on_floor() and $CoyoteTimer.is_stopped():
			$"/root/Helpers".apply_camera_shake(0.75)
			hasDoubleJump = false
		$CoyoteTimer.stop()
		
	#check if jump is not being pressed 
	if  velocity.y < 0 and !Input.is_action_pressed("jump"):
		velocity.y += gravity*jumpTerminationMultiplier*delta
	else:
		velocity.y += gravity * delta
	
	
	var wasOnFloor = is_on_floor()	
	move_and_slide()
	
	if wasOnFloor and not is_on_floor():
		$CoyoteTimer.start()
	if (!wasOnFloor) and is_on_floor() and not isStateNew:
		spawn_footsteps(2)
	
	if is_on_floor():
		hasDoubleJump = true
		hasDash = true
	
	if hasDash and Input.is_action_just_pressed("dash_state"):
		#queue in main thread 
		call_deferred("change_state", State.DASHING)
		hasDash = false
	
	update_animation()
	isStateNew = false
	
	
func get_move_vector():
	var moveVector = Vector2.ZERO
	moveVector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	moveVector.y = -1 if Input.is_action_just_pressed("jump") else 0
	return moveVector
	
func update_animation():
	var move_vec = get_move_vector()
	if !is_on_floor():
		$AnimatedSprite2D.play("jump")
	elif move_vec.x != 0:
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")
	
	if move_vec.x != 0:
		$AnimatedSprite2D.flip_h = true if move_vec.x > 0 else false
		
func call_on_died():
	if isDying:
		return
		
	isDying = true	
	var death = playerDeath.instantiate()
	get_parent().add_child(death)
	death.global_position = self.global_position
	death.velocity.x = velocity.x
	death.flip_h = $AnimatedSprite2D.flip_h
	emit_signal("died")

func on_spike_entered(area2d):
	$"/root/Helpers".apply_camera_shake(1)
	call_deferred("call_on_died")
	
func spawn_footsteps(scale = 1):
	var footstep = footStepParticles.instantiate()
	get_parent().add_child(footstep)
	footstep.scale = Vector2.ONE * scale
	footstep.global_position = global_position
	$FootStepAudioPlayer.play()

func on_animated_sprite_frame_changed():
	if ($AnimatedSprite2D.animation == "run" and $AnimatedSprite2D.frame == 0):
		spawn_footsteps()

func disable_player_input():
	change_state(State.INPUT_DISABLED)
	
func on_yapıs_entered(area2d):
	jumpSpeed=0
	maxDashSpeed=1
	minDashSpeed=1
	maxSpeed=90
func on_yapıs_exited(area2d):
	jumpSpeed=420
	maxDashSpeed = 600
	minDashSpeed = 200
	maxSpeed=120
	
func on_zıpla_entered(area2d):
	jumpSpeed=1200

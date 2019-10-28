extends KinematicBody2D

var MAX_SPEED = 300
var ACCELERATION = 10000
var motion = Vector2.ZERO

var upgrade = false

const BULLET = preload("Bullet.tscn")

onready var raycast = $RayCast2D
	
func _physics_process(delta):
	move(delta)
	aim()
	shoot2()
	
func move(delta):
	var axis = Vector2.ZERO
	axis.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	axis.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	axis = axis.normalized()
	if axis == Vector2.ZERO:
		apply_friction(ACCELERATION * delta)
	else:
		apply_movement(axis * ACCELERATION * delta)
	motion = move_and_slide(motion)

func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO

func apply_movement(acceleration):
	motion += acceleration
	motion = motion.clamped(MAX_SPEED)

func aim():
	var look_vec = get_global_mouse_position() - global_position
	global_rotation = atan2(look_vec.y, look_vec.x)

func shoot():
	if Input.is_action_just_pressed("shoot"):
		$Gun.play()
		var coll = raycast.get_collider()
		if raycast.is_colliding() and coll.has_method("kill"):
			coll.kill()
			
func shoot2():
	if upgrade:
		$GunTimer.wait_time = 0.13
		if Input.is_action_pressed("shoot"):
			if $GunTimer.is_stopped():
				create_bullet()
				$GunTimer.start()
	else:
		$GunTimer.wait_time = 0.25
		if Input.is_action_just_pressed("shoot"):
			if $GunTimer.is_stopped():
				create_bullet()
				$GunTimer.start()

func create_bullet():
	$Gun.play()
	var bullet = BULLET.instance()
	get_parent().add_child(bullet)
	bullet.position = $Position2D.global_position
	var trajectory = Vector2(cos(global_rotation), sin(global_rotation))
	bullet.speed_x = trajectory.x
	bullet.speed_y = trajectory.y

func kill():
	get_tree().reload_current_scene()

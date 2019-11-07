extends KinematicBody2D

var MAX_SPEED = 200
var ACCELERATION = 10000
var motion = Vector2.ZERO
var dying = false

signal add_score

const BLOOD = preload("BloodSplurt.tscn")

onready var raycast = $RayCast2D

var player = null

func _ready():
	if !is_in_group("zombies"):
		add_to_group("zombies")
	
func _physics_process(delta):
	move(delta)
	attack()

func move(delta):
	if not dying:
		# Find player and move towards them
		player = get_tree().get_nodes_in_group("player")[0]
		if player == null:
			return
		var vec_to_player = player.global_position - global_position
		vec_to_player = vec_to_player.normalized()
		global_rotation = atan2(vec_to_player.y, vec_to_player.x)
		
		# Move towards player
		var acceleration = vec_to_player * ACCELERATION * delta
		motion += acceleration
		motion = motion.clamped(MAX_SPEED)
		move_and_slide(motion)

func attack():
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll.name == "Player":
			coll.kill()
			
func kill(bullet_vector):
	dying = true
	emit_signal("add_score", 1)
	var blood = BLOOD.instance()
	get_parent().add_child(blood)
	blood.global_rotation = get_blood_direction(blood, bullet_vector)
	$RayCast2D.enabled = false
	$CollisionShape2D.set_deferred("disabled", true)
	$DeathSound.play()
	yield($DeathSound, "finished")
	queue_free()

func set_player(p):
	player = p
	
func get_blood_direction(blood, bullet_vector):
	var blood_location = Vector2()
	blood_location.x = position.x - bullet_vector.x
	blood_location.y = position.y - bullet_vector.y
	var length = sqrt(blood_location.x * blood_location.x + blood_location.y + blood_location.y)
#	blood_location.x = vx / length * size + position.x
#	blood_location.y = vy / length * size + position.y
	var angle = atan2(blood_location.y, blood_location.x) + PI/2;
	return angle
	

extends KinematicBody2D

var MAX_SPEED = 200
var ACCELERATION = 10000
var motion = Vector2.ZERO

onready var raycast = $RayCast2D

var player = null

func _ready():
	add_to_group("zombies")
	
func _physics_process(delta):
	move(delta)
	attack()

func move(delta):
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
	motion = move_and_slide(motion)

func attack():
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll.name == "Player":
			coll.kill()
			
func kill():
	hide()
	$RayCast2D.enabled = false
	$CollisionShape2D.set_deferred("disabled", true)
	$DeathSound.play()
	yield($DeathSound, "finished")
	queue_free()

	
func set_player(p):
	player = p
		
	
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
	if dying:
		pass
	else:
		# Find player and move towards them
		player = get_tree().get_nodes_in_group("player")[0]
		if player == null:
			return
		var vec_to_player = player.global_position - global_position
		vec_to_player = vec_to_player.normalized()
		# atan2 gives you the angle between the x-axis and the vector (x,y) in radians
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
			
func kill(bullet):
	dying = true
	emit_signal("add_score", 1)
	spawn_blood(bullet)
	$RayCast2D.enabled = false
#	$CollisionShape2D.set_deferred("disabled", true)
	$DeathSound.play()
	yield($DeathSound, "finished")
#	queue_free()

func set_player(p):
	player = p
	
func spawn_blood(bullet):
	var blood = BLOOD.instance()
	get_parent().add_child(blood)
	
	# Position the blood
	var c_shape = $CollisionShape2D.shape
	var bullet_shape = bullet.get_node("CollisionShape2D").shape
	var intersect_list = c_shape.collide_and_get_contacts(transform, bullet_shape, bullet.transform)
	if intersect_list.size() > 0:
		blood.position = intersect_list[0]
	
	# Rotate the blood
	# TODO: We need to figure out the current rotation of the bullet compared to the WORLD
	# We then set the blood to be the same rotation.
	
	var s = blood.position.normalized().dot(global_position)
	
	print(str(bullet.position) + ", " + str(bullet.global_position) + ", " + str(bullet.ro))


#	var bullet_dir = bullet.global_position.normalized()
	# atan2 gives you the angle between the x-axis and the vector (x,y) in radians
#	blood.global_rotation = atan2(bullet_dir.y, bullet_dir.x)
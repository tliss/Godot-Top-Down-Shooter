extends Node2D

export (PackedScene) var Mob
var score
const PICKUP = preload("Pickup.tscn")

var rng = RandomNumberGenerator.new()

func _ready():
	randomize()
	rng.randomize()
	
func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.set_offset(randi())
	var mob = Mob.instance()
	add_child(mob)
	mob.position = $MobPath/MobSpawnLocation.position
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	mob.rotation = direction
	mob.connect("add_score", $HUD, "update_score")
	
func _on_PickupTimer_timeout():
	var pickup = PICKUP.instance()
	add_child(pickup)

	var sprite = pickup.get_node("Area2D/Sprite")
	var sprite_size_x = sprite.texture.get_size().x * sprite.scale.x
	var sprite_size_y = sprite.texture.get_size().y * sprite.scale.y
	var pickup_size = Vector2(ceil(sprite_size_x), ceil(sprite_size_y))
	
	var location = Vector2()
	location.x = rng.randi_range(pickup_size.x / 2, 2560 - (pickup_size.x / 2))
	location.y = rng.randi_range(pickup_size.y / 2, 2560 - (pickup_size.y / 2))
	
	pickup.position = location

	pickup.connect("uzi_pickup", $HUD, "add_weapon")
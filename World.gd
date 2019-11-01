extends Node2D

export (PackedScene) var Mob
var score
const PICKUP = preload("Pickup.tscn")

func _ready():
	randomize()
	
func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.set_offset(randi())
	var mob = Mob.instance()
	add_child(mob)

	mob.position = $MobPath/MobSpawnLocation.position

	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	mob.rotation = direction

	mob.connect("add_score", $HUD, "update_score")
	pass

func _on_PickupTimer_timeout():
	var pickup = PICKUP.instance()
	add_child(pickup)
	pickup.position = (Vector2(800, 300))
	pickup.connect("uzi_pickup", $HUD, "add_weapon")

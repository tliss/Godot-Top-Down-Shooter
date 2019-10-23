extends Node2D

export (PackedScene) var Mob
var score

func _ready():
    randomize()

func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.set_offset(randi())
	var mob = Mob.instance()
	add_child(mob)

	mob.position = $MobPath/MobSpawnLocation.position

	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
#	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
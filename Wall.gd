extends StaticBody2D

const BLOOD = preload("BloodSplurt.tscn")

func _ready():
	pass

func bullet_hit(bullet):
	var puff = BLOOD.instance()
	get_parent().add_child(puff)
	puff.global_position = bullet.global_position
	puff.rotation = bullet.inherited_rotation
extends Node2D

signal uzi_pickup

func _ready():
	pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.upgrade = true
		emit_signal("uzi_pickup", "uzi")
		queue_free()

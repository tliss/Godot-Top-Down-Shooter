extends Area2D

signal uzi_pickup

func _ready():
	pass # Replace with function body.

func _on_Pickup_body_entered(body):
	if body.is_in_group("player"):
		body.upgrade = true
		emit_signal("uzi_pickup", "uzi")
		queue_free()
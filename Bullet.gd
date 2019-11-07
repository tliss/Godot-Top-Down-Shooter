extends Area2D

const SPEED = 400
var speed_x = 0
var speed_y = 0

func _process(delta):
		var motion = Vector2(speed_x, speed_y) * SPEED
		position = position + motion * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_body_entered(body):
	if body.is_in_group("zombies"):
		body.kill(global_position)
		queue_free()
	if body.is_in_group("obstacle"):
		queue_free()

extends Area2D

const SPEED = 400
var speed_x = 0
var speed_y = 0

var bullet_penetrating = []

func _process(delta):
		var motion = Vector2(speed_x, speed_y) * SPEED
		position = position + motion * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_body_entered(body):
	if body.is_in_group("zombies"):
		body.kill(self)
		queue_free()
	if body.is_in_group("obstacle"):
		queue_free()

func _on_Bullet_body_shape_entered(body_id, body, body_shape, area_shape):
	bullet_penetrating.append(get_overlapping_bodies()[0])

func _on_Bullet_body_shape_exited(body_id, body, body_shape, area_shape):
	bullet_penetrating.pop_front()
	if bullet_penetrating.size() == 0:
		queue_free()
		# body.bullet_hit(self)

extends Node2D

func _draw():
	var cen = $AmmoCountPos.position
	var rad = 16
	var col = Color(0.53, 0.59, 0.69, 0.5)
	draw_circle (cen, rad, col)
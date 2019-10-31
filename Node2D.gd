extends Node2D

func _ready():
	pass

func _draw():
	var cen = get_node("../UziIcon").rect_position
#    var cen = Vector2(25, 25)

	var rad = 20
	var col = Color(0, 0, 1)
	draw_circle (cen, rad, col)
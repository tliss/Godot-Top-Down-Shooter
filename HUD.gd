extends CanvasLayer

func _ready():
	pass

func update_score(new_points):
    $ScoreLabel.text = str(int($ScoreLabel.text) + new_points)
	
func add_weapon(weapon):
	if weapon == "uzi":
		$UziIcon.visible = true
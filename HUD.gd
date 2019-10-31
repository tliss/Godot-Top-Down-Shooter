extends CanvasLayer

const WEAPON = preload("WeaponHUDIcon.tscn")

func update_score(new_points):
    $ScoreLabel.text = str(int($ScoreLabel.text) + new_points)
	
func add_weapon(weapon):
	if weapon == "uzi":
		var new_weapon = WEAPON.instance()
		$WeaponBar.add_child(new_weapon)
		new_weapon.add_ammo(60)
		
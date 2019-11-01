extends CanvasLayer

const WEAPON = preload("WeaponHUDIcon.tscn")
const UZI_AMMO = 10

var weapons = []

func update_score(new_points):
    $ScoreLabel.text = str(int($ScoreLabel.text) + new_points)

func add_weapon(weapon):
	if weapon == "uzi" and !weapons.has("uzi"):
		var new_weapon = WEAPON.instance()
		$WeaponBar.add_child(new_weapon)
		new_weapon.add_ammo(UZI_AMMO)
		weapons.append("uzi")
	else:
		$WeaponBar.get_node("WeaponHUDIcon").add_ammo(UZI_AMMO)
		
func remove_weapon(weapon):
	if weapon == "uzi" and weapons.has("uzi"):
		weapons.erase("uzi")
		$WeaponBar.get_node("WeaponHUDIcon").queue_free()
		
extends Control

func add_ammo(count):
	var current_ammo = int($AmmoCount/AmmoText.text)
	$AmmoCount/AmmoText.text = str(current_ammo + count)
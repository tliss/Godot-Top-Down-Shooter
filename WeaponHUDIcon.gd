extends Control

var AmmoCount = 0

func add_ammo(count):
	AmmoCount = AmmoCount + count	
	$AmmoCount/AmmoText.text = str(AmmoCount)
	
func sub_ammo(count):
	AmmoCount = AmmoCount - count
	$AmmoCount/AmmoText.text = str(AmmoCount)
	
func get_ammo():
	return AmmoCount
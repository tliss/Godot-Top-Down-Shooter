extends CanvasLayer

func _ready():
	pass

func update_score(new_points):
    $ScoreLabel.text = str(int($ScoreLabel.text) + new_points)
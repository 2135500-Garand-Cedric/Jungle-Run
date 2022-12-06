extends CanvasLayer


onready var score = $AspectRatioContainer/HBoxContainer/ScoreVal
onready var vies = $AspectRatioContainer/HBoxContainer/ViesVal
onready var level = $AspectRatioContainer/HBoxContainer/LevelVal

# Rafraichi le GUI
func _process(delta):
	score.text = str(Global.score)
	level.text = str(Global.level)
	vies.text = str(Global.vies)

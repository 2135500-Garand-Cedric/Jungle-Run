extends Node

var levels = [preload("res://scenes/Level1.tscn"),preload("res://scenes/Level2.tscn")]
onready var popup = $Popup
onready var label = $Popup/Label
onready var button = $Popup/Button
var current_level = 0
var current_level_node
onready var player = $Player

func _ready():
	player.visible = false
	popup.visible = true


func _on_Level_Finished():
	var next_level = (current_level + 1) % levels.size()
	var next_level_node = levels[next_level].instance()
	current_level = next_level
	
	next_level_node.connect("finished", self, "_on_Level_Finished")
	current_level_node.queue_free()
	add_child(next_level_node)
	current_level_node = next_level_node

func _on_player_dead():
	current_level_node.queue_free()
	player.visible = false
	popup.visible = true
	label.text = "\nVous avez perdu\n\nScore:54"
	button.text = "Recommencer"
	current_level = 0
	player.visual.play("default")
	player.niveau_plateforme = 2
	player.score = 0


func _on_button_pressed():
	popup.visible = false
	player.visible = true
	player.position.x = 94
	player.position.y = 496
	current_level_node = levels[current_level].instance()
	current_level_node.connect("finished",self,"_on_Level_Finished")
	add_child(current_level_node)

extends Node

var levels = [preload("res://scenes/Level1.tscn"),preload("res://scenes/Level2.tscn"),preload("res://scenes/Level3.tscn")]
onready var popup = $Popup
onready var label = $Popup/Label
onready var button = $Popup/Button
onready var gui = $GUI
var current_level = 0
var current_level_node
onready var player = $Player

# Affiche le bouton pour commencer
func _ready():
	popup.visible = true
	player.connect("player_dead", self, "_on_player_dead")
	button.connect("pressed", self, "_on_button_pressed")

# Instancie le prochain niveau et l'affiche a l'ecran
func _on_Level_Finished():
	var next_level = (current_level + 1) % levels.size()
	var next_level_node = levels[next_level].instance()
	current_level = next_level
	Global.level += 1
	next_level_node.connect("finished", self, "_on_Level_Finished")
	current_level_node.queue_free()
	add_child(next_level_node)
	current_level_node = next_level_node

# Affiche le popup de fin lorsque le joueur est mort
func _on_player_dead():
	current_level_node.queue_free()
	player.visible = false
	popup.visible = true
	gui.visible = false
	label.text = "\nVous avez perdu\n\nScore: " + str(Global.score)
	button.text = "Recommencer"

# Demarre le niveau 1 lorsque le bouton commencer ou recommencer se fait clicker
func _on_button_pressed():
	_set_base_config()
	popup.visible = false
	player.visible = true
	gui.visible = true
	player.position.x = 94
	player.position.y = 496
	current_level_node = levels[current_level].instance()
	current_level_node.connect("finished",self,"_on_Level_Finished")
	add_child(current_level_node)

# Mets les configs de base pour le niveau 1
func _set_base_config():
	current_level = 0
	player.visual.play("default")
	Global.niveau_plateforme = 2
	player.time = 0
	player.emitted = false
	Global.score = 0
	Global.level = 1
	Global.vies = 3

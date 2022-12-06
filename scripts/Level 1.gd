extends Node2D

signal finished()

onready var spawner = $EnemySpawnPoints
onready var player = get_parent().get_node("Player")
onready var plateformes = [$Plateforme/Plateforme0/Collider, $Plateforme/Plateforme1/Collider, $Plateforme/Plateforme2/Collider, $Plateforme/Plateforme3/Collider]

func _ready():
	print("lvl1")
	player.plateformes = plateformes

# Envoi des enemis tant que le joueur n'a pas 5000 points de score
func _on_Timer_timeout():
	if Global.score < 5000:
		spawner._send_enemy(1)
	else:
		emit_signal("finished")

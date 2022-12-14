extends Node2D

signal finished()

onready var spawner = $EnemySpawnPoints
onready var player = get_parent().get_node("Player")
onready var plateformes = [$Plateformes/Plateforme0/Collider, $Plateformes/Plateforme1/Collider, $Plateformes/Plateforme2/Collider, $Plateformes/Plateforme3/Collider]

func _ready():
	print("lvl2")
	player.plateformes = plateformes

# Envoi des enemis
func _on_Timer_timeout():
	if Global.score < 20000:
		spawner._send_enemy(2)
	else:
		emit_signal("finished")
	

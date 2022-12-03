extends Node2D

signal finished()

onready var spawner = $EnemySpawnPoints
onready var player = get_parent().get_node("Player")

func _ready():
	print("lvl1")

func _on_Timer_timeout():
	if player.score < 100000000:
		spawner._send_enemy(1)
		player.score += 100
	else:
		emit_signal("finished")

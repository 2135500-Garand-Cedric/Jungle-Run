extends Node2D

onready var spawner = $EnemySpawnPoints

func _ready():
	print("lvl2")

func _on_Timer_timeout():
	spawner._send_enemy(2)
	

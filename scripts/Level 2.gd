extends Node2D

onready var spawner = $EnemySpawnPoints
onready var player = get_parent().get_node("Player")
onready var plateformes = [$Plateformes/Plateforme0/Collider, $Plateformes/Plateforme1/Collider, $Plateformes/Plateforme2/Collider, $Plateformes/Plateforme3/Collider]

func _ready():
	print("lvl2")
	player.plateformes = plateformes

func _on_Timer_timeout():
	spawner._send_enemy(2)
	

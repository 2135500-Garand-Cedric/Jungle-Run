extends Node2D

# Enemis possibles
var Enemy = preload("res://scenes/Enemy.tscn")
var FastEnemy = preload("res://scenes/FastEnemy.tscn")
var RushEnemy = preload("res://scenes/RushEnemy.tscn")
var rng = RandomNumberGenerator.new()
# Spawn points possibles
onready var spawns = [$Spawn0, $Spawn1, $Spawn2, $Spawn3]
var enemy
var rusher = false

# Selon le niveau et le nombre aleatoire genere, envoi un certain type d'enemi sur une certaine plateforme
func _send_enemy(level):
	rusher = false
	rng.randomize()
	var spawn_point = rng.randi_range(0,3)
	rng.randomize()
	var zombie_level = rng.randi_range(1,10)
	if zombie_level > 7 and level == 1:
		enemy = FastEnemy.instance()
	elif zombie_level <= 7 and level == 1:
		enemy = Enemy.instance()
	elif zombie_level > 8 and level == 2:
		enemy = RushEnemy.instance()
		rusher = true
	elif zombie_level > 3 and level == 2:
		enemy = FastEnemy.instance()
	elif zombie_level <= 3 and level == 2:
		enemy = Enemy.instance()
	if rusher:
		enemy._spawn(spawns[spawn_point].global_position, spawn_point)
	else:
		enemy._spawn(spawns[spawn_point].global_position)
	get_parent().add_child(enemy)

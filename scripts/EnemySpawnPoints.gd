extends Node2D

var Enemy = preload("res://scenes/Enemy.tscn")
var FastEnemy = preload("res://scenes/FastEnemy.tscn")
var rng = RandomNumberGenerator.new()
onready var spawns = [$Spawn0, $Spawn1, $Spawn2, $Spawn3]
var enemy


func _send_enemy(level):
	rng.randomize()
	var spawn_point = rng.randi_range(0,3)
	rng.randomize()
	var zombie_level = rng.randi_range(1,10)
	if zombie_level > 7 and level == 1:
		enemy = FastEnemy.instance()
	elif zombie_level <= 7 and level == 1:
		enemy = Enemy.instance()
	elif zombie_level > 8 and level == 2:
		#a modifier
		enemy = FastEnemy.instance()
	elif zombie_level > 3 and level == 2:
		enemy = FastEnemy.instance()
	elif zombie_level <= 3 and level == 2:
		enemy = Enemy.instance()
	enemy._spawn(spawns[spawn_point].global_position)
	get_parent().add_child(enemy)

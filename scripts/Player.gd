extends KinematicBody2D

# variable déterminant la vitesse
# exportée pour pouvoir la modifier dans l'éditeur
export var speed : int = 300
# variables pour instancier les armes
var Shuriken = preload("res://scenes/Shuriken.tscn")
# variable pour espacer les tirs
var cannonsReady = true

# variable contenant le vecteur final de déplacement
var velocity = Vector2();


func _physics_process(delta):
	# gestion des entrées de l'utilisateur
	getInput()
	# déplacement
	var collision = move_and_collide(velocity * speed * delta)
	# contact avec une balle ou un ennemi
	if collision:
		$Visual.play("dead")
	if $Visual.animation == "dead" and $Visual.frame == 4:
		$Visual.playing = false
		$Visual.frame = 4
	if $Visual.animation == "jump" and $Visual.frame == 8:
		$Visual.play("default")
		$Visual.frame = 0
		

# getInput
# 
# Selon les entrées de l'utilisateur
# - modifie les variable de déplacement 
# - active les armes
func getInput():
	velocity = Vector2()
	if Input.is_action_just_pressed("shoot"):
		var bullet = Shuriken.instance()
		bullet._shoot(position)
		get_parent().add_child(bullet)
	elif Input.is_action_just_pressed("up"):
		$Visual.play("jump")
	elif Input.is_action_just_pressed("down"):
		$Visual.play("jump")
	velocity = velocity.normalized()

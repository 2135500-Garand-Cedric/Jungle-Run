extends KinematicBody2D

# variable déterminant la vitesse
# exportée pour pouvoir la modifier dans l'éditeur
export var speed = 500.0
export var gravity = 250.0
var plateforme = 3
# variables pour instancier les armes
var Shuriken = preload("res://scenes/Shuriken.tscn")
# variable pour espacer les tirs

onready var plateformes = []

# variable contenant le vecteur final de déplacement
var velocity = Vector2();


func _physics_process(delta):
	# gestion des entrées de l'utilisateur
	velocity.x = 0
	getInput()
	# déplacement
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name != "Plateforme" and collision.collider.name != "Plateforme2" and collision.collider.name != "Plateforme3" and collision.collider.name != "Plateforme4":
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
func getInput():
	if Input.is_action_pressed("left"):
		velocity.x += -speed
		$Visual.flip_h = true
	if Input.is_action_pressed("right"):
		velocity.x += speed
		$Visual.flip_h = false
	if Input.is_action_just_pressed("shoot"):
		var bullet = Shuriken.instance()
		bullet._shoot(position)
		get_parent().add_child(bullet)
	elif Input.is_action_just_pressed("up"):
		
		$Visual.play("jump")
	elif Input.is_action_just_pressed("down"):
		$Visual.play("jump")

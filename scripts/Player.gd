extends KinematicBody2D

# variable déterminant la vitesse
# exportée pour pouvoir la modifier dans l'éditeur
export var speed = 450.0
export var gravity = 500.0
export var score = 0
var niveau_plateforme = 2
# variables pour instancier les armes
var Shuriken = preload("res://scenes/Shuriken.tscn")
var plateformes
var generate = true
# variable contenant le vecteur final de déplacement
var velocity = Vector2();


func _physics_process(delta):
	if generate:
		plateformes = [get_node("/root/Main/Level1/Plateforme/Plateforme0/Collider"), get_node("/root/Main/Level1/Plateforme/Plateforme1/Collider"), get_node("/root/Main/Level1/Plateforme/Plateforme2/Collider"), get_node("/root/Main/Level1/Plateforme/Plateforme3/Collider")]
		generate = false
	# gestion des entrées de l'utilisateur
	velocity.x = 0
	getInput()
	# déplacement
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "Enemy":
			$Visual.play("dead")
	if $Visual.animation == "dead" and $Visual.frame == 4:
		$Visual.playing = false
		$Visual.frame = 4
	if $Visual.animation == "jump" and $Visual.frame == 8:
		$Visual.play("default")
		$Visual.frame = 0
		for i in range(4):
			plateformes[i].disabled = false
		

# getInput
# 
# Selon les entrées de l'utilisateur
# - modifie les variable de déplacement 
func getInput():
	if Input.is_action_pressed("left")and position .x >= 60:
		velocity.x += -speed
		$Visual.flip_h = true
	if Input.is_action_pressed("right") and position.x <= 1450:
		velocity.x += speed
		$Visual.flip_h = false
	if Input.is_action_just_pressed("shoot"):
		var bullet = Shuriken.instance()
		bullet._shoot(position, $Visual.flip_h)
		get_parent().add_child(bullet)
	elif Input.is_action_just_pressed("up") and is_on_floor() and niveau_plateforme != 0:
		plateformes[niveau_plateforme-1].disabled = true
		velocity.y += -450
		niveau_plateforme += -1
		$Visual.play("jump")
	elif Input.is_action_just_pressed("down") and is_on_floor() and niveau_plateforme != 3:
		plateformes[niveau_plateforme].disabled = true
		velocity.y += -100
		niveau_plateforme += 1
		$Visual.play("jump")


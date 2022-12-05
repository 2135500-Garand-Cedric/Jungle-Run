extends KinematicBody2D

signal player_dead()
# variable déterminant la vitesse
# exportée pour pouvoir la modifier dans l'éditeur
export var speed = 450.0
export var gravity = 500.0
var niveau_plateforme = 2
# variables pour instancier les armes
var Shuriken = preload("res://scenes/Shuriken.tscn")
var plateformes
onready var visual = $Visual
# variable contenant le vecteur final de déplacement
var velocity = Vector2();
var emitted = false
var time = 0

func _process(delta):
	if Global.vies <= 0 and !emitted:
		emit_signal("player_dead")
		emitted = true

func _physics_process(delta):
	# gestion des entrées de l'utilisateur
	velocity.x = 0
	getInput()
	# déplacement
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "Enemy":
			visual.play("dead")
	if visual.animation == "dead" and visual.frame == 4:
		visual.playing = false
		visual.frame = 4
		time += delta
		if !emitted and time >= 0.5:
			emit_signal("player_dead")
			emitted = true
	if visual.animation == "jump" and visual.frame == 8:
		visual.play("default")
		visual.frame = 0
		for i in range(4):
			plateformes[i].disabled = false
		

# getInput
# 
# Selon les entrées de l'utilisateur
# - modifie les variable de déplacement 
func getInput():
	if Input.is_action_pressed("left")and position .x >= 60:
		velocity.x += -speed
		visual.flip_h = true
	if Input.is_action_pressed("right") and position.x <= 1450:
		velocity.x += speed
		visual.flip_h = false
	if Input.is_action_just_pressed("shoot"):
		var bullet = Shuriken.instance()
		bullet._shoot(position, visual.flip_h)
		get_parent().add_child(bullet)
	elif Input.is_action_just_pressed("up") and is_on_floor() and niveau_plateforme != 0:
		plateformes[niveau_plateforme-1].disabled = true
		velocity.y += -450
		niveau_plateforme += -1
		visual.play("jump")
	elif Input.is_action_just_pressed("down") and is_on_floor() and niveau_plateforme != 3:
		plateformes[niveau_plateforme].disabled = true
		velocity.y += -100
		niveau_plateforme += 1
		visual.play("jump")
		



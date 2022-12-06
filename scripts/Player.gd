extends KinematicBody2D

signal player_dead()
export var speed = 450.0
export var gravity = 500.0
var niveau_plateforme = 2
var Shuriken = preload("res://scenes/Shuriken.tscn")
var plateformes
onready var visual = $Visual
var velocity = Vector2();
var emitted = false
var time = 0

func _process(delta):
	if Global.vies <= 0 and !emitted:
		emit_signal("player_dead")
		emitted = true

# S'occupe du deplacement du joueur
func _physics_process(delta):
	velocity.x = 0
	# Obtient le deplacement du joueur
	getInput()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	# Affiche le visuel du deplacement
	showVisual(delta)

# Fait certains actions selon les boutons que l'utilisateur appuie
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
		
# Affiche le visuel du joueur
func showVisual(delta):
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
	



extends KinematicBody2D

export var speed = 75
export var running_speed = 250
var velocity = Vector2(-speed,0)
var niveau_plateforme
var time = 0
var vies = 2

# Spawn l'enemi
func _spawn(pos, niv_plateforme):
	position = pos
	niveau_plateforme = niv_plateforme

# S'occupe du mouvement de l'enemi
func _physics_process(delta):
	if $Visual.animation == "dead":
		if $Visual.frame == 4:
			queue_free()
			Global.score += 250
	else:
		if niveau_plateforme == Global.niveau_plateforme:
			time += delta
			if time >= 0.5:
				if position.x > Global.posx_joueur:
					velocity = Vector2(-running_speed,0)
					$Visual.flip_h = true
					$Visual.play("running")
				elif position.x < Global.posx_joueur:
					velocity = Vector2(running_speed,0)
					$Visual.flip_h = false
					$Visual.play("running")
		else:
			time = 0
			velocity = Vector2(-speed,0)
			$Visual.play("walking")
			$Visual.flip_h = true
	var collision = move_and_collide(velocity * delta)
	if position.x <= -100:
		queue_free()
		Global.vies += -vies

# Lorsqu'il y a qqch qui entre dans la zone de collision de l'enemi
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.visual.play("dead")
	else:
		vies += -1
		body.queue_free()
	if vies <= 0:
		$Visual.play("dead")
		velocity = Vector2(0,0)
		$Area2D.queue_free()

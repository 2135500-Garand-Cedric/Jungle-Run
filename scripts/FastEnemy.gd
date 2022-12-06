extends KinematicBody2D

export var speed = 200
var velocity = Vector2(-speed,0)

# Spawn l'enemi
func _spawn(pos):
	position = pos

# S'occupe du mouvement de l'enemi
func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if position.x <= -100:
		queue_free()
		Global.vies += -1
	if $Visual.animation == "dead" and $Visual.frame == 4:
		queue_free()
		Global.score += 150

# Lorsqu'il y a qqch qui entre dans la zone de collision de l'enemi
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.visual.play("dead")
	else:
		body.queue_free()
		$Visual.play("dead")
		$Visual.flip_h = false
		velocity = Vector2(0,0)
		$Area2D.queue_free()

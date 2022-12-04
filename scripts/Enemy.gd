extends KinematicBody2D

export var speed = 100
var velocity = Vector2(-speed,0)

func _spawn(pos):
	position = pos

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if position.x <= -100:
		queue_free()
	if $Visual.animation == "dead" and $Visual.frame == 4:
		queue_free()

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.visual.play("dead")
	else:
		body.queue_free()
		$Visual.play("dead")
		velocity = Vector2(0,0)
		$Area2D.queue_free()

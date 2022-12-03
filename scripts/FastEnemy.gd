extends KinematicBody2D


export var speed = 200
var velocity = Vector2(-speed,0)

func _spawn(pos):
	position = pos

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if position.x <= -100:
		queue_free()



func _on_Area2D_body_entered(body):
	body.queue_free()
	queue_free()

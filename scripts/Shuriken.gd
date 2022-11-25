extends KinematicBody2D

export var speed = 500
var velocity = Vector2()


func _shoot(pos):
	position.x = pos.x + 55
	position.y = pos.y
	velocity = Vector2(speed,0)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		queue_free()

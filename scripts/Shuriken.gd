extends KinematicBody2D

export var speed = 600
var velocity = Vector2()


func _shoot(pos, flip_h):
	position.y = pos.y
	if flip_h:
		position.x = pos.x - 55
		velocity = Vector2(-speed,0)
	else:
		position.x = pos.x + 55
		velocity = Vector2(speed,0)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		queue_free()
	if position.x >= 2000 or position.x <= -100:
		queue_free()

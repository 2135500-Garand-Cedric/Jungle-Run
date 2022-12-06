extends KinematicBody2D

export var speed = 600
var velocity = Vector2()
onready var timer = $Timer
var lifespan = 0

# Envoi le shuriken dans une certaine direction dependant l'orientation du joueur
func _shoot(pos, flip_h):
	position.y = pos.y
	if flip_h:
		position.x = pos.x - 55
		velocity = Vector2(-speed,0)
	else:
		position.x = pos.x + 55
		velocity = Vector2(speed,0)

# Deplace le shuriken tant qu'il ne touche pas qqch ou qu'il est hors de l'ecran
func _physics_process(delta):
	lifespan += delta
	var collision = move_and_collide(velocity * delta)
	if collision:
		timer.start()
	if lifespan >= 1.25:
		queue_free()


func _on_Timer_timeout():
	queue_free()

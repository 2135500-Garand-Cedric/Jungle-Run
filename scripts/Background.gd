extends CanvasLayer


export var startPosY = 500
export var speed = 5

onready var bg = [$Sprite, $Sprite2, $Sprite3]

var startPosX = 4000

# Place les trois images
func _ready():
	var posX = startPosX
	var posY = startPosY
	
	for screen in bg:
		screen.position.x = posX
		screen.position.y = posY
		posX -= 2000
		

# Fait tourner les trois images une a la suite de l'autre
func _physics_process(delta):
	for screen in bg:
		screen.position.x -= speed
		if screen.position.x <= -2000:
			screen.position.x = startPosX 

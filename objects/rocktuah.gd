extends CharacterBody2D
class_name rocktuah
const SPEED = 300.0

var moving = "no"
var last_position = position
var intended_position = position

func startMovement(direction):
	if moving == "no":
		last_position = position
		if direction[0] > 0:
			moving = "right"
			intended_position = last_position + Vector2(32,0)
			print("right")
		if direction[0] < 0:
			moving = "left"
			print("left")
			intended_position = last_position + Vector2(-32,0)
		if direction[1] > 0:
			moving = "down"
			print("down")
			intended_position = last_position + Vector2(0,32)
		if direction[1] < 0:
			moving = "up"
			print("up")
			intended_position = last_position + Vector2(0,-32)

func _physics_process(delta: float) -> void:
	
	if Global.world == "p":
		$Rock.visible = true
	if Global.world == "s":
		$Rock.visible = false
	
	if moving != "no":
		move_and_slide()
		if moving == "right":
			velocity = Vector2(200,0)
			if position[0] > intended_position[0]:
				position = intended_position
				velocity = Vector2(0,0)
				moving = "no"
		if moving == "left":
			velocity = Vector2(-200,0)
			if position[0] < intended_position[0]:
				position = intended_position
				velocity = Vector2(0,0)
				moving = "no"
		if moving == "down":
			velocity = Vector2(0,200)
			if position[1] > intended_position[1]:
				position = intended_position
				velocity = Vector2(0,0)
				moving = "no"
		if moving == "up":
			velocity = Vector2(0,-200)
			if position[1] < intended_position[1]:
				position = intended_position
				velocity = Vector2(0,0)
				moving = "no"
	
		

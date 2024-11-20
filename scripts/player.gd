extends CharacterBody2D
class_name Player

@export var speed = 200

@onready var player: Player = $"."
@onready var rock: CharacterBody2D = $"../rock2"

var on_wire = [false, null]
@onready var last_position_p = position
@onready var last_position_s = position

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_E:  # KEY_E is an integer, not a string
			print("E key pressed!")
			if on_wire[0] and Global.world == "s":
				on_wire[1].toggleVisibility()
				remove_wire()
		if event.keycode == KEY_Q:
			if Global.world == "p":
				go_spiritual()
			else:
				go_physical()
				


func set_wire(wire):
	on_wire[0] = true
	on_wire[1] = wire
	
func remove_wire():
	on_wire[0] = false
	on_wire[1] = null
	
func go_spiritual():
	last_position_p = position
	position = last_position_s
	Global.changeWorld()
	
func go_physical():
	last_position_s = position
	position = last_position_p
	Global.changeWorld()

func _physics_process(delta):
	get_input()

	var collision_info = move_and_collide(velocity*delta)
	if collision_info:
		if str(collision_info.get_collider()).substr(0, 4) == "rock" and Global.world == "p":
			collision_info.get_collider().startMovement(velocity)
		if str(collision_info.get_collider()).substr(0, 5) == "enemy":
			print("dead")
			get_tree().quit()
		if str(collision_info.get_collider()).substr(0, 4) == "Boss":
			print("dead")
			get_tree().quit()
		
		

	#if player.is_colliding():
	#	var collider = player.get_collider()
	#	if collider == rock:
	#		print("Player collided with the enemy!")
	
	if Input.is_action_just_pressed("lights"):
		Global.lights = !Global.lights

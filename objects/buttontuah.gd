extends CharacterBody2D
#extends Area2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var door: CharacterBody2D = $"../door1"

#$Area2D.connect("body_entered", self, "_on_body_entered")
	
func press():
	door.open()


func _on_area_2d_body_entered(body: Node2D) -> void:
	press()
	print('yo')

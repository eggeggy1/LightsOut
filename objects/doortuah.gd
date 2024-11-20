extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var opened = false

#do sprites
func open():
	opened = true
	
func close():
	opened = false

func _physics_process(delta: float) -> void:
	if Global.world == "p":
		$DoorSprite.visible = true
	if Global.world == "s":
		$DoorSprite.visible = false
	
	if opened:
		$CollisionShape2D.disabled = true
	if not opened:
		$CollisionShape2D.disabled = false
	pass
#move_and_slide()

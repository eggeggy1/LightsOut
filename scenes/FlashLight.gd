extends PointLight2D

func _physics_process(delta):
	visible = Global.flash
	
	if Input.is_action_just_pressed("flash"):
		if Global.flashCoolDown == 0 && Global.flashLast == 0:
			Global.flash = !Global.flash
			Global.flashCoolDown = 1200
			Global.flashLast = 30

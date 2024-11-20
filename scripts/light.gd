extends PointLight2D

func _physics_process(delta):
	scale = Vector2.ONE * (1.05 if Global.lights else 0.4)

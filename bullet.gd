extends Node2D

var speed = 40  # Bullet speed
var direction = Vector2()  # Direction of movement


func _ready():
	# Set the bullet's velocity based on the direction
	direction = direction.normalized()  # Ensure the direction is a unit vector


func set_angle(ang):
	$Bullet.rotation = ang
func _process(delta: float) -> void:
	# Move the bullet each frame

	position = position + direction * speed * delta

	# Optional: Add bullet lifetime for cleanup (destroy after time)
	#if position.x < 0 or position.y < 0 or position.x > get_viewport().size.x or position.y > get_viewport().size.y:
	#	queue_free()  # Destroy the bullet if it goes off-screen

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	if body.is_in_group("Player"):
		get_tree().quit()
		print("U DEAD")
	elif not body.is_in_group("turrets"):
		queue_free()

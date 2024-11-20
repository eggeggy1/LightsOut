extends CharacterBody2D
class_name Turret

@onready var player: Player = $"../Player"

#"static" is pointing same direction, "sweep" moves back and forth in an arc, "track" aims at player
@export var type = "track"
@export var firerate: float = 1.0
@export var angle_range = 3.14/4 #left and right
@export var initial_angle = -3.14/2
@export var turn_velocity = 0.6
@export var shooting_timer: Timer
@export var bullet_scene: PackedScene
@export var direction = 0

func _ready():
	#rotation = 0
	#initial_angle = rotation
	
	shooting_timer = Timer.new()
	shooting_timer.wait_time = firerate
	shooting_timer.one_shot = false
	shooting_timer.autostart = true
	add_child(shooting_timer)
	shooting_timer.connect("timeout", Callable(self, "_on_shooting_timer_timeout"))
	
	bullet_scene = preload("res://Bullet.tscn")
	

func _physics_process(delta: float) -> void:
	if type == "track":
		direction = (player.position - position).rotated(PI/2).normalized()
		rotation = direction.angle()
	if type == "sweep":
		direction = Vector2(cos(rotation), sin(rotation))
		rotation += turn_velocity * delta 
		if turn_velocity > 0 and rotation > initial_angle + angle_range or turn_velocity < 0 and rotation < initial_angle - angle_range:
			turn_velocity = -turn_velocity
	if type == "static":
		direction = Vector2(cos(rotation), sin(rotation))
		
func _on_shooting_timer_timeout() -> void:
	shoot_bullet()
	
func shoot_bullet() -> void:
	if bullet_scene:
		var bullet = bullet_scene.instantiate()
		get_tree().current_scene.add_child(bullet)  # Add the bullet to the scene
		bullet.position = position  # Start the bullet at the turret position
		bullet.direction = -direction.rotated(PI/2)  # Point the bullet towards the target
		bullet.set_angle(rotation)

extends CharacterBody2D

var speed = 110
var enemVelocity = Vector2.ZERO

# Variables for wander behavior
var wander_target = Vector2.ZERO
var wander_change_interval = 10.0  # Minimum time before changing direction
var wander_timer = 0.0

# Aggro range detection
var player_in_range = false

enum State {
	CHASE,
	WANDER,
	FOUND
}

var state = State.WANDER

@onready var player: Player = $"../Player"

func _on_agro_range_body_entered(body):
	if body == player:
		player_in_range = true
		state = State.CHASE

func _on_agro_range_body_exited(body):
	if body == player:
		player_in_range = false
		state = State.WANDER

func _physics_process(delta):
	# Switch to chase state if the lights are on, regardless of agro range
	if Global.lights:
		state = State.CHASE
	elif not player_in_range:
		state = State.WANDER

	match state:
		State.CHASE:
			move(player.global_position, delta)
		
		State.WANDER:
			wander(delta)

func move(target_position, delta):
	var direction = (target_position - global_position).normalized()
	var desired_velocity = direction * speed
	var steering = (desired_velocity - enemVelocity) * delta * 2.5
	enemVelocity += steering
	
	position += enemVelocity * delta
	


func wander(delta):
	wander_timer -= delta
	if wander_timer <= 0:
		wander_timer = 10.0 + randf() * 5.0
		
		var random_angle = randf() * TAU 
		wander_target = Vector2(cos(random_angle), sin(random_angle)).normalized()
	
	var desired_velocity = wander_target * speed
	var steering = (desired_velocity - enemVelocity) * delta * 2.5
	enemVelocity += steering
	
	position += enemVelocity * delta

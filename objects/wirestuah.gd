extends CharacterBody2D
@onready var wires_menu: Control = $"../WiresLayer/wiresmenu"
@onready var player: Player = $"../Player"
@onready var wirestuah: Node = self
@onready var door: CharacterBody2D = $"../door2"

var completed = false


func toggleVisibility():
	wires_menu.visible = not wires_menu.visible
	
func _physics_process(delta: float) -> void:
	pass

func complete():
	door.open()
	wires_menu.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	
	player.set_wire(wirestuah)

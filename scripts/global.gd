extends Node

var lights = false
var world = "p"
signal world_changed(world)

func changeWorld():
	if world == "p":
		world = "s"
	else:
		world = "p"
	emit_signal("world_changed", world)

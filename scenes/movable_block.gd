extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.connect("world_changed", Callable(self, "_on_world_changed"))



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

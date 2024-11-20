extends Control

var start_circle = null  # The starting circle for a wire connection
var end_circle = null    # The ending circle for a wire connection
var active_line_color = Color(1, 1, 1)  # Active wire color (white)
var completed_lines = []  # Stores completed lines as arrays [start_pos, end_pos, color]
var circle_colors = {}  # Stores color IDs for circles
@onready  var wires: CharacterBody2D = $"../../wires2"

#maybe import each one individually up above
func _ready():
	# Assign unique color IDs to circles (modify as needed for your nodes)
	circle_colors = {
		$HBoxContainer/VBoxContainer/TextureLeftRed: "red",
		$HBoxContainer/VBoxContainer/TextureLeftBlue: "blue",
		$HBoxContainer/VBoxContainer/TextureLeftGreen: "green",
		$HBoxContainer/VBoxContainer/TextureLeftPink: "pink",
		$HBoxContainer/VBoxContainer2/TextureRightRed: "red",
		$HBoxContainer/VBoxContainer2/TextureRightBlue: "blue",
		$HBoxContainer/VBoxContainer2/TextureRightGreen: "green",
		$HBoxContainer/VBoxContainer2/TextureRightPink: "pink"
	}
	print(circle_colors)

	# Debugging to ensure circle paths are correct
	print($VBoxContainer/TextureLeftRed)  # Ensure this is a valid node

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:  # On mouse press
			var mouse_pos = get_global_mouse_position()
			start_circle = _find_nearest_circle(mouse_pos)
		else:  # On mouse release
			var mouse_pos = get_global_mouse_position()
			end_circle = _find_nearest_circle(mouse_pos)
			
			if start_circle and end_circle and _colors_match(start_circle, end_circle):
				# Add the line to completed lines
				completed_lines.append([start_circle.global_position - Vector2(350, 165), end_circle.global_position - Vector2(350, 165), active_line_color])
			else:
				# Invalid connection (optional feedback)
				print("Invalid connection!")
			
			# Reset active connection
			start_circle = null
			end_circle = null
			queue_redraw()  # Refresh the drawing

	elif event is InputEventMouseMotion and start_circle:
		# Update the active wire endpoint while dragging
		end_circle = null
		queue_redraw()  # Refresh the drawing

func _find_nearest_circle(pos):
	# Check all circles for proximity
	print(circle_colors)
	print(circle_colors.keys())
	for circle in circle_colors.keys():
		if circle.get_global_rect().has_point(pos):
			return circle
	return null

func _colors_match(start, end):
	# Verify that the colors of the start and end circles match
	return circle_colors[start] == circle_colors[end]

func _draw():
	# Draw all completed lines
	for line in completed_lines:
		draw_line(line[0], line[1], line[2], 5)
		
	if len(completed_lines) == 4:
		wires.complete()

	# Draw the active line if in progress
	if start_circle:
		var start_pos = start_circle.global_position - Vector2(350, 165)
		var end_pos = get_global_mouse_position() - Vector2(350, 165)
		draw_line(start_pos, end_pos, active_line_color, 5)

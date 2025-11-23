extends Area2D

var mouse_inside := false
var click_pos: Array = []

func _ready():
	connect("mouse_entered", _on_enter)
	connect("mouse_exited", _on_exit)
	z_index = 1

func _on_enter():
	mouse_inside = true

func _on_exit():
	mouse_inside = false

func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var local_pos = get_local_mouse_position()
		if mouse_inside:
			click_pos.append(local_pos)
			queue_redraw()
			print("in")
		else:
			print("out")

func _draw():
	for point in click_pos:
		draw_circle(point, 10, Color.RED)

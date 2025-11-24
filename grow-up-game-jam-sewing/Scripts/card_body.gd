extends RigidBody2D

signal clicked
signal exit_left(signaler, velocity, type, notion_type, notions, position)
signal exit_right(signaler, velocity, type, notion_type, notions, position)

var held = false
var friction = Vector2(10,10)
var type
var child

var scene_root

func _ready():
	contact_monitor = true
	max_contacts_reported = 10

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print("clicked")
			clicked.emit(self)

func _physics_process(delta: float) -> void:
	if held:
		global_transform.origin = get_global_mouse_position()
		
func pickup():
	if held:
		return
	freeze = true
	held = true

func drop(impulse=Vector2.ZERO):
	if held:
		freeze = false
		apply_central_impulse(impulse)
		held = false
		set_linear_damp(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("emit oob signal")
	if global_position.x < 0:
		print("exit left")
		if type == "clothing":
			exit_left.emit(self,linear_velocity,type,"blank",child.notions, global_position)
		else:
			exit_left.emit(self,linear_velocity,type,child.notion_type,null, global_position)
	elif global_position.x > 648:
		if type == "clothing":
			exit_right.emit(self,linear_velocity,type,"blank",child.notions, global_position)
		else:
			exit_right.emit(self,linear_velocity,type,child.notion_type,null, global_position)
		print("exit right")

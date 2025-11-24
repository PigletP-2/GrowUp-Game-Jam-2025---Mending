extends RigidBody2D

signal clicked

var held = false
var friction = Vector2(10,10)
var type
var child

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

func _on_body_entered(body: Node) -> void:
	if type == "clothing" and body.type == "notion":
		child.notions.append(body.child.notion_type)
		body.queue_free()
		print(child.notions)

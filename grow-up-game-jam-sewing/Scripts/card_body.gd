extends RigidBody2D

signal clicked

var held = false
var friction = Vector2(10,10)


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
		set_linear_damp(0.1)
		
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

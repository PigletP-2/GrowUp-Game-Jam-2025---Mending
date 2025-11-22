extends Node

@onready var label: Label = $Label # Label to display session id
@onready var tube_client: TubeClient = $TubeClient # reference to tube client in scene tree
@onready var line_edit: LineEdit = $LineEdit # text user input for session id

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void: # User pressed create session button.
	tube_client.create_session()
	label.text = tube_client.session_id


func _on_button_2_pressed() -> void: # User pressed join session button.
	tube_client.join_session(line_edit.text)


func _on_tube_client__session_initiated() -> void:
	print("Session initiated")


func _on_tube_client_session_created() -> void:
	print("Session created")


func _on_tube_client_session_joined() -> void:
	print("Session joined")

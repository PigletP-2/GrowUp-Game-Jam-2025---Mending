extends Node

@onready var label: Label = $Label # Label to display session id
@onready var tube_client: TubeClient = $TubeClient # reference to tube client in scene tree
@onready var line_edit: LineEdit = $LineEdit # text user input for session id
var playerIDs = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var multiplayer_api = get_tree().get_multiplayer()
	multiplayer_api.peer_connected.connect(on_peer_connected)
	#multiplayer_api.peer_disconnected.connect("on_peer_disconnected")
	#if not multiplayer_api.is_server():
		##multiplayer_api.connected_to_server.connect("on_connected_to_server")
		##multiplayer_api.connection_failed.connect("on_connection_failed")
		##multiplayer_api.server_disconnected.connect("on_server_disconnected")
	#else:
		#playerIDs.append(multiplayer_api.get_unique_id())


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
	
 
func on_peer_connected(id: int):
	print("Player added: ", id);
	playerIDs.append(id)

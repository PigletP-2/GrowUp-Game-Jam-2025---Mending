extends Node2D

const PORT = 123
const SERVER_ADDRESS = "localhost"

var peer =  ENetMultiplayerPeer.new()

@export var player_field_scene : PackedScene
@export var player_2_field_scene : PackedScene

func _on_host_button_pressed() -> void:
	disable_button()
	
	peer.create_server(PORT)
	
	multiplayer.multiplayer_peer = peer
	
	var player_scene = player_field_scene.instantiate()
	add_child(player_scene)

func _on_join_button_pressed() -> void:
	disable_button()
	
	peer.create_client(SERVER_ADDRESS, PORT)

	multiplayer.multiplayer_peer = peer 
	
	multiplayer.peer_connected.connect(_on_peer_connected)
	
	
	var player_scene = player_field_scene.instantiate()
	add_child(player_scene)
	
	

func _on_peer_connected(peer_id):
	print("Player Joined")
	print("Player Joined!")
	
func disable_button():
	$HostButton.disabled = true
	$HostButton.visible = false
	$JoinButton.disabled = true
	$JoinButton.visible = false

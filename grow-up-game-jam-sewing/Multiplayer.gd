extends Node2D

const PORT = 123
const SERVER_ADDRESS = "localhost"

var peer =  ENetMultiplayerPeer.new()
var peerIDs = []

@export var player_field_scene : PackedScene
#@export var player_2_field_scene : PackedScene



func _on_host_button_pressed() -> void:
	disable_button()
	
	peer.create_server(PORT)
	
	multiplayer.multiplayer_peer = peer
	
	var player_scene = player_field_scene.instantiate()
	print("Sensie")
	add_child(player_scene)
	

	

func _on_join_button_pressed() -> void:
	disable_button()
	
	peer.create_client(SERVER_ADDRESS, PORT)

	multiplayer.multiplayer_peer = peer 
	
	multiplayer.peer_connected.connect(_on_peer_connected)
	
	
	var player_scene = player_field_scene.instantiate()
	add_child(player_scene)
	
func _on_peer_connected(peer_id):
	peerIDs.append(peer_id)
	print(peer_id)
	
	
func disable_button():
	$HostButton.disabled = true
	$HostButton.visible = false
	$JoinButton.disabled = true
	$JoinButton.visible = false

@rpc("any_peer","unreliable","call_remote")
func print_own_id():
	if multiplayer.get_unique_id() != get_multiplayer_authority():
		print("Peepee: ", multiplayer.get_unique_id(), get_multiplayer_authority())
	if multiplayer.get_remote_sender_id() != 1:
		print("not server: ", multiplayer.get_remote_sender_id())
	if !multiplayer.is_server(): 
		print("Received RPC at: ", multiplayer.get_unique_id())
	

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_T:
			peerIDs = multiplayer.get_peers()
			print(multiplayer.get_unique_id())
			print_own_id.rpc_id(peerIDs[0])
			

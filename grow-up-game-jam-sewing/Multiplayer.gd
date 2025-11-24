extends Node2D

const PORT = 123
const SERVER_ADDRESS = "localhost"
const CARD_BODY_REF = preload("res://card_body.tscn")
const CLOTH_REF = preload("res://clothing_info.tscn")
const NOTION_REF = preload("res://notion_info.tscn")

var ticket_manager
var peer =  ENetMultiplayerPeer.new()
var peerIDs = []

#@export var player_field_scene : PackedScene
#@export var player_2_field_scene : PackedScene

func _ready() -> void:
	ticket_manager = $Node2D/TicketManager

func _on_host_button_pressed() -> void:
	disable_button()
	
	peer.create_server(PORT)
	
	multiplayer.multiplayer_peer = peer
	
	#var player_scene = player_field_scene.instantiate()
	#print("Sensie")
	#add_child(player_scene)
	

	

func _on_join_button_pressed() -> void:
	disable_button()
	
	peer.create_client(SERVER_ADDRESS, PORT)

	multiplayer.multiplayer_peer = peer 
	
	multiplayer.peer_connected.connect(_on_peer_connected)
	
	
	#var player_scene = player_field_scene.instantiate()
	#add_child(player_scene)
	
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
	
@rpc("any_peer","unreliable","call_remote")
func _spawn_thrown_card(velocity: Variant, type: Variant, notion_type: Variant, notions: Variant, position: Variant):
	print("try spawn")
	var item = CARD_BODY_REF.instantiate()
	ticket_manager.add_child(item)
	item.position = position
	item.apply_central_impulse(velocity)
	var info
	if type == "clothing":
		info = CLOTH_REF.instantiate()
		item.add_child(info)
		info.notions = notions
	else:
		info = NOTION_REF.instantiate()
		item.add_child(info)
		info.notion_type = notion_type
		
		

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_T:
			peerIDs = multiplayer.get_peers()
			print(multiplayer.get_unique_id())
			print_own_id.rpc_id(peerIDs[0])
			print(peerIDs)


func _on_card_body_exit_left(signaler: Variant, velocity: Variant, type: Variant, notion_type: Variant, notions: Variant, position: Variant) -> void:
	signaler.queue_free()
	print("receive exit left")
	_spawn_thrown_card.rpc_id(peerIDs[0], velocity, type, notion_type, notions, Vector2(648,position.y))


func _on_card_body_exit_right(signaler: Variant, velocity: Variant, type: Variant, notion_type: Variant, notions: Variant, position: Variant) -> void:
	print("receive exit right")
	signaler.queue_free()
	_spawn_thrown_card.rpc_id(peerIDs[0], velocity, type, notion_type, notions, Vector2(0,position.y))

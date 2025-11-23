extends Node2D

signal card_spawned

const TICKET_REF = preload("res://ticket_node.tscn")

var ticket_timer
var current_tickets = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ticket_timer = $TicketTime
	ticket_timer.timeout.connect(_create_ticket)
	_create_ticket()
	ticket_timer.start(5.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _create_ticket():
	if current_tickets < 5:
		var new_ticket = TICKET_REF.instantiate()
		add_child(new_ticket)
		card_spawned.emit()
		current_tickets += 1
		print("ticket made")
	ticket_timer.start(5.0)

	

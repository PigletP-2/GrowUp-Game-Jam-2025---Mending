extends Node2D

var parent 
var notions = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	parent.child = self
	parent.type = "clothing"

extends Node2D

var type
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match rng.randi_range(1,5):
		1:
			type = "RedButton"
		2:
			type = "BlueButton"
		3: 
			type = "YellowButton"
		4:
			type = "Patch"
		5:
			type = "ThreadAndNeedle"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends Node2D

const CARD_REF = preload("res://card_body.tscn")
const CLOTHING_REF = preload("res://clothing_info.tscn")

var tasks = {"RedButts": 0, "BlueButts": 0, "YellowButts": 0, "Patches": 0}
var needs_sewing = false
var rng = RandomNumberGenerator.new()
var item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item = CARD_REF.instantiate()
	var clothing_info = CLOTHING_REF.instantiate()
	add_child(item)
	item.add_child(clothing_info)
	item.set_position(Vector2(100,100))
	pick_tasks()
	print("card made")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func pick_tasks():
	if rng.randi_range(0,1):
		needs_sewing = true
	for i in rng.randi_range(3,5):
		match rng.randi_range(1,4):
			1:
				tasks["RedButts"] += 1
			2:
				tasks["BlueButts"] += 1
			3:
				tasks["YellowButts"] += 1
			4: 
				tasks["Patches"] += 1
			

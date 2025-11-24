extends Area2D

const CARD_REF = preload("res://card_body.tscn")
const CLOTHING_REF = preload("res://clothing_info.tscn")

var tasks = {"RedButts": 0, "BlueButts": 0, "YellowButts": 0, "Patches": 0}
var needs_sewing = false
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var item = CARD_REF.instantiate()
	item.type = "clothing"
	get_parent().add_child(item)
	var clothing_info = CLOTHING_REF.instantiate()
	item.add_child(clothing_info)
	item.set_position(Vector2(100,100))
	pick_tasks()
	set_monitoring(true)
	print("card made")

func pick_tasks():
	if rng.randi_range(0,1):
		needs_sewing = true
	for i in rng.randi_range(3,5):
		match rng.randi_range(1,4):
			1:
				tasks["RedButts"] += 1
				print(tasks["RedButts"])
			2:
				tasks["BlueButts"] += 1
				print(tasks["BlueButts"])
			3:
				tasks["YellowButts"] += 1
				print(tasks["YellowButts"])
			4: 
				tasks["Patches"] += 1
				print(tasks["Patches"])

func _on_body_entered(body: Node2D) -> void:
	print("body entered")
	if body.type == "clothing":
		for i in body.child.notions:
			print(i)
			match i:
				"RedButton":
					tasks["RedButts"] -= 1
					print(tasks["RedButts"])
				"BlueButton":
					tasks["BlueButts"] -= 1
					print(tasks["BlueButts"])					
				"YellowButton":
					tasks["YellowButts"] -= 1
					print(tasks["YellowButts"])					
				"Patch":
					tasks["Patches"] -= 1
					print(tasks["Patches"])					
				"ThreadAndNeedle":
					needs_sewing = false
		if needs_sewing == false and tasks["RedButts"] == 0 and tasks["BlueButts"] == 0 and tasks["YellowButts"] == 0 and tasks["Patches"] == 0:
			print("success")
			body.queue_free()
			queue_free()
		else:
			print("failed")
			body.queue_free()
			queue_free()
				

extends Node2D

var notion_type
var parent 
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	parent.child = self
	parent.type = "notion"
	var sprite = $Sprite2D
	match rng.randi_range(1,5):
		1:
			notion_type = "RedButton"
			sprite.texture = preload("res://Sprites/red_button.png")
		2:
			notion_type = "BlueButton"
			sprite.texture = preload("res://Sprites/Button.png")
		3: 
			notion_type = "YellowButton"
			sprite.texture = preload("res://Sprites/yellow_button.png")
		4:
			notion_type = "Patch"
			sprite.texture = preload("res://Sprites/patch.png")
		5:
			notion_type = "ThreadAndNeedle"
			sprite.texture = preload("res://Sprites/needle.png")

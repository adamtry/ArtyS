extends Node

var unit_scene = preload("res://Scenes/Unit/Unit.tscn")

func _ready():
	var xpos = 100
	var ypos = 100
	for colour in [Color.RED, Color.BLUE]:
		for i in range(0, 3):
			var unit = unit_scene.instantiate()
			unit.position.x = xpos
			unit.position.y = ypos
			unit.colour = colour
			ypos += 100
			add_child(unit)
		xpos += 800
		ypos = 100

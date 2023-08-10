extends CharacterBody2D

@export var selected = false
@onready var box = get_node("Box")

@onready var target = position
var follow_cursor = false
var speed = 50

var target_coords: Array[Vector2]

func _ready():
	set_selected(selected)
	target_coords = []

func set_selected(value):
	selected = value
	box.visible = value

func _input(event):
	if event.is_action_pressed("move"):
		follow_cursor = true
	if event.is_action_released("move"):
		follow_cursor = false

func _physics_process(delta):
	handle_selection()
	
	if follow_cursor == true:
		if selected:
			if Input.is_action_just_pressed("queue_move"):
				target_coords.append(get_global_mouse_position())
			elif Input.is_action_just_pressed("move"):
				target_coords = [get_global_mouse_position()]
	if target_coords:
		velocity = position.direction_to(target_coords[0]) * speed
		if position.distance_to(target_coords[0]) > 15:
			move_and_slide()

func handle_selection():
	if Input.is_action_just_pressed("select"):
		var click_pos = get_global_mouse_position()
		if click_pos.distance_to(position) < $Sprite.texture.get_width():
			if not selected:
				$Sprite.modulate = Color.CORNFLOWER_BLUE
				selected = true
		else:
			selected = false
			
	if selected:
		$Sprite.modulate = Color.CORNFLOWER_BLUE
	else:
		$Sprite.modulate = Color.WHITE

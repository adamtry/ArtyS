extends CharacterBody2D

@export var selected = false;

const SPEED: float = 300
const STOP_DISTANCE = 20
var target = Vector2.ZERO;

func _ready():
	position.x = 500
	position.y = 500
	target = position
	velocity = Vector2.ZERO


func _process(delta):
	if selected or velocity != Vector2.ZERO:
		handle_move_commands()

	# Select when clicked
	if Input.is_action_just_pressed("left_click"):
		var click_pos = get_global_mouse_position()
		if click_pos.distance_to(position) < self.get_node("Sprite2D").texture.get_width():
			_toggle_select(true)
		else:
			_toggle_select(false)


func _toggle_select(on=true):
	if not selected and on:
		self.get_node("Sprite2D").modulate = Color(0, 0, 1)
		selected = true
	if selected and not on:
		self.get_node("Sprite2D").modulate = Color(1, 1, 1)
		selected = false


func handle_move_commands():
	if Input.is_action_just_pressed("right_click"):
		target = get_global_mouse_position()
	if position.distance_to(target) > STOP_DISTANCE:
		velocity = position.direction_to(target) * SPEED
	else:
		velocity = Vector2.ZERO
	move_and_slide()
	

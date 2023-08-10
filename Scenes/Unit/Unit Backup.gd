extends CharacterBody2D

const SPEED: float = 5
const STOP_DISTANCE = 20

var selected: bool
# List of coordinates to visit in sequence
var target_coords: Array[Vector2]

func _ready():
	selected = false
	target_coords = []

func _physics_process(delta):
	handle_selection()
	if selected or len(target_coords) > 0:
		handle_move_commands()


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


func handle_move_commands():
	if Input.is_action_just_pressed("queue_move"):
		target_coords.append(get_global_mouse_position())
	elif Input.is_action_just_pressed("move"):
		target_coords = [get_global_mouse_position()]
	if target_coords:
		if position.distance_to(target_coords[0]) > STOP_DISTANCE:
			velocity = position.direction_to(target_coords[0]) * SPEED
			rotation = velocity.angle()
			print("TARGET: ", target_coords[0], " VELOCITY: ", velocity)
			print("ANGLE: ", velocity.angle())
		else:
			velocity = Vector2.ZERO
			target_coords = target_coords.slice(1)
			print("Stationary with v=", velocity)
		move_and_slide()

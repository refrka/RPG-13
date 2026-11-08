class_name PlayerMovementComponent extends MovementComponent




var input_dir: Vector2

var move_left_pressed:= false

var move_right_pressed:= false

var move_up_pressed:= false

var move_down_pressed:= false







func deactivate() -> void:

	super()

	move_left_pressed = false

	move_right_pressed = false

	move_up_pressed = false

	move_down_pressed = false






func get_move_dir() -> Vector2:

	var dir:= Vector2.ZERO

	if move_left_pressed:

		if not Input.is_action_pressed("move_left"):

			move_left_pressed = false

		else:

			dir += Vector2.LEFT

	if move_right_pressed:

		if not Input.is_action_pressed("move_right"):

			move_right_pressed = false

		else:

			dir += Vector2.RIGHT

	if move_up_pressed:

		if not Input.is_action_pressed("move_up"):

			move_up_pressed = false

		else:

			dir += Vector2.UP

	if move_down_pressed:

		if not Input.is_action_pressed("move_down"):

			move_down_pressed = false

		else:

			dir += Vector2.DOWN

	if Input.get_vector("move_left", "move_right", "move_up", "move_down") == Vector2.ZERO:

		return Vector2.ZERO

	input_dir = dir.normalized()

	return input_dir



func get_face_dir() -> Vector2:

	return input_dir.normalized()



func get_move_speed() -> float:

	return (100.0 + get_speed_modifier()) * get_speed_multiplier()





func _unhandled_input(event: InputEvent) -> void:

	if not active:

		return

	if event.is_action("move_left"):

		move_left_pressed = event.is_pressed()

	if event.is_action("move_right"):

		move_right_pressed = event.is_pressed()

	if event.is_action("move_up"):

		move_up_pressed = event.is_pressed()

	if event.is_action("move_down"):

		move_down_pressed = event.is_pressed()
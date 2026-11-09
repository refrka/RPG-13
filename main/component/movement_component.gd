class_name MovementComponent extends Component



signal face_dir_changed(dir: Vector2)



var velocity: Vector2

var face_dir: Vector2

var move_dir: Vector2


var movement_enabled:= true

var rotation_enabled:= true



var modifier_tracker:= ModifierTracker.new()








func set_face_dir(dir: Vector2 = Vector2.ZERO) -> void:

	if dir != face_dir and dir != Vector2.ZERO:

		face_dir = dir

		face_dir_changed.emit(dir)







func get_move_dir() -> Vector2:

	return Vector2.ZERO


func get_move_speed() -> float:

	return (50.0 + get_speed_modifier()) * get_speed_multiplier()


func get_speed_modifier() -> float:

	return modifier_tracker.get_float_add()


func get_speed_multiplier() -> float:

	return modifier_tracker.get_float_multiply()


func get_velocity_modifier() -> Vector2:

	return modifier_tracker.get_vector()


func get_velocity() -> Vector2:

	return (move_dir * get_move_speed()) + get_velocity_modifier()


func get_face_dir() -> Vector2:

	return entity.velocity.normalized()







func deactivate() -> void:

	super()

	entity.velocity = Vector2.ZERO







func _physics_process(delta: float) -> void:

	if not active:

		return

	var current_velocity = entity.velocity

	move_dir = get_move_dir()

	velocity = get_velocity()

	if movement_enabled:

		if velocity == Vector2.ZERO:

			entity.velocity = current_velocity.move_toward(Vector2.ZERO, 25.0)

		else:

			entity.velocity = current_velocity.move_toward(velocity, 30.0)

		entity.move_and_slide()

	if rotation_enabled:

		set_face_dir(move_dir.normalized())

	modifier_tracker.tick(delta)
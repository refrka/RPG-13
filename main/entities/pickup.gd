class_name Pickup extends Entity


@export var pickup_sensor: Sensor


var item: Item

var float_to_entity: Entity



func initialize() -> void:

	super()

	pickup_sensor.body_entered_sensor.connect(_on_body_entered_pickup_sensor)

	pickup_sensor.monitoring = false

	anim_player.animation_finished.connect(_on_animation_finished)









func load_item(_item: Item) -> void:

	item = _item

	body_sprite.texture = _item.icon_texture

	body_sprite.offset.y = -_item.icon_texture.get_height() / 2

	center_marker.position = body_sprite.offset

	pickup_sensor.position = body_sprite.offset





func float_to(entity: Entity) -> void:

	float_to_entity = entity

	shadow_sprite.visible = not is_instance_valid(entity)

	if is_instance_valid(entity):

		shadow_sprite.visible = false

		anim_player.stop()





func enable_pickup_sensor() -> void:

	pickup_sensor.monitoring = true

	if not pickup_sensor.bodies.is_empty():

		float_to(pickup_sensor.bodies[0])





static func new_pickup(item: Item) -> Pickup:

	var pickup = load("res://main/entities/pickup.tscn").instantiate()

	pickup.load_item(item)

	return pickup





func _on_body_entered_pickup_sensor(body: PhysicsBody2D) -> void:

	float_to(body)





func _on_animation_finished(anim_name: String) -> void:

	if anim_name == "drop":

		enable_pickup_sensor()





func _process(_delta: float) -> void:

	if is_instance_valid(float_to_entity):

		var target_position = float_to_entity.center_marker.global_position

		var distance = center_marker.global_position.distance_to(target_position)

		if distance <= 3.0:

			if float_to_entity.inventory.add_items(item) <= 0:

				queue_free()

		else:

			global_position = global_position.move_toward(target_position - center_marker.position, 3.0)
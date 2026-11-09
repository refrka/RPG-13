class_name InteractionSensor extends Sensor




var interactable_entities: Array



func initialize(_entity: Entity = null) -> void:

	super(_entity)

	if entity:

		var movement_component = entity.get_component(MovementComponent)

		movement_component.face_dir_changed.connect(_on_face_dir_changed)




func _on_body_entered_sensor(body: PhysicsBody2D) -> void:

	super(body)

	if bodies.has(body) and body is Entity and body.is_interactable():

		var interactable_component = body.get_interactable_component()

		if interactable_component.can_interact():

			interactable_entities.append(body)




func _on_body_exited_sensor(body: PhysicsBody2D) -> void:

	super(body)

	if interactable_entities.has(body):

		interactable_entities.erase(body)




func _on_face_dir_changed(dir: Vector2) -> void:

	rotation = dir.angle()
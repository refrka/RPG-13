class_name Sensor extends Area2D


signal body_entered_sensor(body: PhysicsBody2D)

signal body_exited_sensor(body: PhysicsBody2D)

signal area_entered_sensor(area: Area2D)

signal area_exited_sensor(area: Area2D)


var active:= false

var entity: Entity

var areas: Array[Area2D]

var bodies: Array[PhysicsBody2D]



func initialize(_entity: Entity = null) -> void:

	entity = _entity

	area_entered.connect(_on_area_entered_sensor)

	area_exited.connect(_on_area_exited_sensor)

	body_entered.connect(_on_body_entered_sensor)

	body_exited.connect(_on_body_exited_sensor)






func activate() -> void:

	active = true



func deactivate() -> void:

	active = false










func _on_area_entered_sensor(area: Area2D) -> void:

	if not areas.has(area):

		areas.append(area)

		area_entered_sensor.emit(area)



func _on_area_exited_sensor(area: Area2D) -> void:

	if areas.has(area):

		areas.erase(area)

		area_exited_sensor.emit(area)



func _on_body_entered_sensor(body: PhysicsBody2D) -> void:

	if body != entity and not bodies.has(body):

		bodies.append(body)

		body_entered_sensor.emit(body)



func _on_body_exited_sensor(body: PhysicsBody2D) -> void:

	if bodies.has(body):

		bodies.append(body)

		body_exited_sensor.emit(body)
class_name TransitionSensor extends Feature



@export var sensor: Sensor

@export var location_id: StringName

@export var spawn_point_id: StringName






func initialize() -> void:

	super()

	sensor.initialize()

	sensor.body_entered_sensor.connect(_on_body_entered_sensor)




func activate() -> void:

	super()

	sensor.activate()



func deactivate() -> void:

	super()

	sensor.deactivate()




func _on_body_entered_sensor(body: PhysicsBody2D) -> void:

	if body is Player and active:

		deactivate()

		Game.player.deactivate()

		Game.change_location.call_deferred(location_id, spawn_point_id)


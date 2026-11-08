class_name Component extends Node




var active:= false

var entity: Entity


func initialize(_entity: Entity) -> void:

	entity = _entity





func activate() -> void:

	active = true




func deactivate() -> void:

	active = false

	
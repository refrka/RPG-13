class_name Component extends Node




var active:= false

var entity: Entity


func initialize(_entity: Entity) -> void:

	entity = _entity





func activate() -> void:

	active = true




func deactivate() -> void:

	active = false

	




func get_component_script() -> Script:

	return get_script()




func get_component_name() -> String:

	return name.trim_suffix("Component")
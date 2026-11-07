class_name GameValue extends Resource


var value: Variant = null



func _init(_value: Variant = null) -> void:

	value = _value


func get_value() -> Variant:

	return value
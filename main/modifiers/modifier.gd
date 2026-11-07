class_name Modifier extends RefCounted


signal expired


enum ValueType {

	FLOAT,

	VECTOR,

}


enum Operator {

	ADD,

	MULTIPLY,

	OVERRIDE,

}


enum ModifierType {

	PASSIVE,

	DECAY,

	DURATION,

}


var value_type: ValueType

var operator: Operator

var modifier_type: ModifierType

var value: Variant

var override:= false

var duration:= -1.0

var decay:= -1.0



var timer:= 0.0






func tick(delta: float) -> void:

	if modifier_type == ModifierType.DECAY:

		value *= clampf(1.0 - decay * delta, 0.0, 1.0)

		if (value is Vector2 and value.length() <= 0.001) or (value is float and value <= 0.001):

			expired.emit()

	elif modifier_type == ModifierType.DURATION:

		timer -= delta

		if timer <= 0.0:

			expired.emit()






static func new_passive(_value: Variant, _operator: Modifier.Operator) -> Modifier:

	var modifier = Modifier.new()

	modifier.value = _value

	modifier.operator = _operator

	modifier.modifier_type = Modifier.ModifierType.PASSIVE

	modifier.value_type = Modifier.ValueType.FLOAT if _value is float else Modifier.ValueType.VECTOR

	return modifier





static func new_duration(_value: Variant, _duration: float, _operator: Modifier.Operator) -> Modifier:

	var modifier = Modifier.new()

	modifier.value = _value

	modifier.duration = _duration

	modifier.operator = _operator

	modifier.modifier_type = Modifier.ModifierType.DURATION

	modifier.value_type = Modifier.ValueType.FLOAT if _value is float else Modifier.ValueType.VECTOR

	return modifier



static func new_decay(_value: Variant, _decay: float, _operator: Modifier.Operator) -> Modifier:

	var modifier = Modifier.new()

	modifier.value = _value

	modifier.decay = _decay

	modifier.operator = _operator

	modifier.modifier_type = Modifier.ModifierType.DECAY

	modifier.value_type = Modifier.ValueType.FLOAT if _value is float else Modifier.ValueType.VECTOR

	return modifier
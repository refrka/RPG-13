class_name ModifierTracker extends Resource






var modifiers: Array[Modifier]




func add_modifier(modifier: Modifier) -> void:

	modifiers.append(modifier)

	modifier.expired.connect(_on_modifier_expired.bind(modifier))




func remove_modifier(modifier: Modifier) -> void:

	modifiers.erase(modifier)




func get_float_multiply() -> float:

	var float_total:= 1.0

	for modifier in modifiers:

		if modifier.value_type == Modifier.ValueType.FLOAT:
			
			if modifier.operator == Modifier.Operator.MULTIPLY:

				float_total *= modifier.value

			elif modifier.operator == Modifier.Operator.OVERRIDE:

				return modifier.value
	
	return float_total



func get_float_add() -> float:

	var float_total:= 1.0

	for modifier in modifiers:

		if modifier.value_type == Modifier.ValueType.FLOAT:
			
			if modifier.operator == Modifier.Operator.ADD:

				float_total += modifier.value

			elif modifier.operator == Modifier.Operator.OVERRIDE:

				return modifier.value
	
	return float_total




func get_vector() -> Vector2:

	var vector_total:= Vector2.ZERO

	for modifier in modifiers:

		if modifier.value_type == Modifier.ValueType.VECTOR:
			
			if modifier.operator == Modifier.Operator.ADD:

				vector_total += modifier.value

			elif modifier.operator == Modifier.Operator.OVERRIDE:

				return modifier.value
	
	return vector_total






func _on_modifier_expired(modifier: Modifier) -> void:

	remove_modifier(modifier)






func tick(delta: float) -> void:

	for modifier in modifiers:

		modifier.tick(delta)


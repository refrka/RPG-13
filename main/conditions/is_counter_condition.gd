class_name IsCounterCondition extends Condition



@export var key: String

@export var value: int

@export_enum("equal", "greater than", "greater than or equal", "less than", "less than or equal") var operator





func evaluate(_data:= {}) -> bool:

	super(_data)

	if data.has("key"):

		key = data.key

	if data.has("value"):

		value = data.value

	if data.has("operator"):

		operator = data.operator

	var current_value = Data.get_counter(key)

	if current_value == -1:

		return false

	match operator:

		"equal":

			return current_value == value

		"greater than":

			return current_value > value

		"greater than or equal":

			return current_value >= value

		"less than":

			return current_value < value

		"less than or equal":

			return current_value <= value

	return false
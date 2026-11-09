class_name IsFlagCondition extends Condition


@export var key: String

@export var value: int

@export var default: int



func evaluate(_data:= {}) -> bool:

	super(_data)

	if data.has("key"):

		key = data.key

	if data.has("value"):

		value = data.value

	if data.has("default"):

		default = data.default

	return Data.get_flag(key) == value
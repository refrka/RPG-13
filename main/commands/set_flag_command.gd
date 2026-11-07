class_name SetFlagCommand extends Command




@export var key: String

@export var value: int




func execute(_data:= {}) -> Result:

	super(_data)

	if data.has("key"):

		key = data.key

	if data.has("value"):

		value = data.value

	print("fuckkkk")

	print(key, value)

	Data.set_flag(key, value)

	return Result.SUCCESS
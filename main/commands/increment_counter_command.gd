class_name IncrementCounterCommand extends Command



@export var key: String



func execute(_data:= {}) -> Result:

	super(_data)

	if data.has("key"):

		key = data.key

	Data.increment_counter(key)

	return Result.SUCCESS
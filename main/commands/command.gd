class_name Command extends Resource


@warning_ignore("unused_signal")

signal command_executed(result: Result)

signal command_cancelled

enum Result {

	PENDING,

	SUCCESS,

	FAILURE,

}



@export var conditions: Array[Condition]

var data: Dictionary





func can_execute(_data:= {}) -> bool:

	var passed:= true

	for condition in conditions:

		if not condition.evaluate(_data):

			passed = false

	return passed




func execute(_data:= {}) -> Result:

	data = _data

	return Result.SUCCESS




func cancel() -> void:

	command_cancelled.emit()




static func run(_data:= {}) -> Result:

	return Result.SUCCESS
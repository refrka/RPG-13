class_name DelayTimerCommand extends Command

@export var duration:= 1.0


var timer: SceneTreeTimer


func execute(_data:= {}) -> Result:

	super(_data)

	if data.has("duration"):

		duration = data.duration

	if duration <= 0.0:

		return Result.SUCCESS

	timer = Game.get_tree().create_timer(duration)

	timer.timeout.connect(_on_timeout, CONNECT_ONE_SHOT)

	return Result.PENDING



func cancel() -> void:

	if timer:

		timer.timeout.disconnect(_on_timeout)



func _on_timeout() -> void:

	command_executed.emit(Result.SUCCESS)
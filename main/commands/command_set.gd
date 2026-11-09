class_name CommandSet extends Resource


signal all_commands_executed


@export var commands: Array[Command]


var active_command: Command

var command_index:= 0

var data:= {}




func execute_all(_data:= {}) -> void:

	data = _data

	command_index = 0

	execute_command_index(command_index)



func cancel() -> void:

	if active_command:

		active_command.command_executed.disconnect(_on_command_executed)

		active_command.cancel()




func get_command(index: int) -> Command:

	if commands.size() - 1 >= index:

		return commands[index]

	return null




func execute_command_index(index: int) -> void:

	var command = get_command(index)

	if not command:

		return

	if not command.can_execute(data):

		command_index += 1

		_on_command_executed(Command.Result.FAILURE, command)

		return

	active_command = command

	match active_command.execute(data):

		Command.Result.PENDING:

			active_command.command_executed.connect(_on_command_executed.bind(active_command), CONNECT_ONE_SHOT)

			active_command.command_cancelled.connect(_on_command_cancelled, CONNECT_ONE_SHOT)

		Command.Result.SUCCESS:

			_on_command_executed(Command.Result.SUCCESS, active_command)

		Command.Result.FAILURE:

			_on_command_executed(Command.Result.FAILURE, active_command)



func is_executing() -> bool:

	return active_command != null



func is_index_valid(index: int) -> bool:

	return commands.size() - 1 >= index



func _on_command_conditions_false() -> void:

	active_command = null

	command_index += 1

	execute_command_index(command_index)




func _on_command_executed(_result: Command.Result, command: Command) -> void:

	if active_command and active_command.command_cancelled.is_connected(_on_command_cancelled):
	
		active_command.command_cancelled.disconnect(_on_command_cancelled)

	active_command = null

	data = command.data

	command_index += 1

	if is_index_valid(command_index):

		execute_command_index(command_index)

	else:

		all_commands_executed.emit()




func _on_command_cancelled() -> void:

	active_command = null






static func run(_commands: Array[Command]) -> CommandSet:

	return null
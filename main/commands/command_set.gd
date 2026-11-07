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

		active_command.cancel()




func get_command(index: int) -> Command:

	if commands.size() - 1 >= index:

		return commands[index]

	return null




func execute_command_index(index: int) -> void:

	var command = get_command(command_index)

	if not command or not command.can_execute(data):

		return

	active_command = command

	match active_command.execute(data):

		Command.Result.PENDING:

			active_command.command_executed.connect(_on_command_executed.bind(active_command), CONNECT_ONE_SHOT)

			active_command.command_cancelled.connect(_on_command_cancelled, CONNECT_ONE_SHOT)

		Command.Result.SUCCESS:

			_on_command_executed(active_command)

		Command.Result.FAILURE:

			pass



func is_executing() -> bool:

	return active_command != null





func _on_command_conditions_false() -> void:

	active_command = null

	command_index += 1

	execute_command_index(command_index)




func _on_command_executed(command: Command) -> void:

	active_command = null

	data = command.data

	command_index += 1

	execute_command_index(command_index)




func _on_command_cancelled() -> void:

	active_command = null
class_name ParallelCommand extends Command



@export var commands: Array[Command]

var executed_commands: Array



func execute(_data:= {}) -> Result:

	super(_data)

	for command in commands:

		match command.execute(data):

			Result.SUCCESS:

				complete_command(command)

			Result.PENDING:

				command.command_executed.connect(_on_parallel_command_executed.bind(command))

	if are_all_commands_executed():

		return Result.SUCCESS

	return Result.PENDING




func are_all_commands_executed() -> bool:

	for command in commands:

		if not executed_commands.has(command):

			return false

	return true



func complete_command(command: Command) -> void:

	executed_commands.append(command)

	if are_all_commands_executed():

		command_executed.emit(Result.SUCCESS)





func _on_parallel_command_executed(command: Command) -> void:

	complete_command(command)
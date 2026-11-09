class_name FadeInCommandSet extends CommandSet







func _init() -> void:

	var fade_fg_command = FadeFGCommand.new()

	fade_fg_command.fade_out = false

	fade_fg_command.rate = -1.0

	commands = [

		fade_fg_command,

	]



static func run(_commands: Array[Command] = [], _data:= {}) -> CommandSet:

	var command_set = FadeInCommandSet.new()

	if not _commands.is_empty():

		command_set.commands = _commands

	command_set.execute_all(_data)

	return command_set
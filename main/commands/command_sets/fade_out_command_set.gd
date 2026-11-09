class_name FadeOutCommandSet extends CommandSet




func _init() -> void:

	var fade_fg_command = FadeFGCommand.new()

	fade_fg_command.fade_out = true

	fade_fg_command.rate = -1.0

	var delay_command = DelayTimerCommand.new()

	delay_command.duration = 1.0

	commands = [

		fade_fg_command,

		delay_command,

	]



static func run(_commands: Array[Command] = [], _data:= {}) -> CommandSet:

	var command_set = FadeOutCommandSet.new()

	if not _commands.is_empty():

		command_set.commands = _commands

	command_set.execute_all(_data)

	return command_set
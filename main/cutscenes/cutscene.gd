class_name Cutscene extends Resource


signal cutscene_ended


@export var cutscene_id: StringName

@export var location_id: StringName

@export var command_set: CommandSet



func run() -> void:

	command_set.all_commands_executed.connect(_on_all_commands_executed, CONNECT_ONE_SHOT)

	command_set.execute_all()



func end() -> void:

	if command_set.is_executing():

		command_set.cancel()

	cutscene_ended.emit()




func _on_all_commands_executed() -> void:

	cutscene_ended.emit()
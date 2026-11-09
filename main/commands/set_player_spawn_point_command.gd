class_name SetPlayerSpawnPointCommand extends Command

@export var spawn_point_id: StringName




func execute(_data:= {}) -> Result:

	super(_data)

	if data.has("spawn_point_id"):

		spawn_point_id = data.spawn_point_id

	Data.active_save_data.spawn_point_id = spawn_point_id

	Data.active_save_data.location_id = Scenes.current_location.location_id

	return Result.SUCCESS





static func run(_data:= {}) -> Command:

	var command = SetPlayerSpawnPointCommand.new()

	command.execute(_data)

	return command
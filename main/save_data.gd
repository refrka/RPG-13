class_name SaveData extends Resource




@export var last_save_unix: float

@export var last_saved_dict: Dictionary




@export var flags: Dictionary

@export var counters: Dictionary

@export var location_id:= CurrentLocationIdGameValue.new()

@export var spawn_point_id:= "start_spawn"





func to_dict() -> Dictionary:

	return {

		"flags": flags,

		"counters": counters,

		"game_data": {

			"last_save_unix": last_save_unix,

			"location_id": location_id.get_value(),

			"spawn_point_id": spawn_point_id,

		}

	}





static func from_dict(dict: Dictionary) -> SaveData:

	var save_data = SaveData.new()

	save_data.last_save_unix = dict.game_data.last_save_unix

	save_data.last_saved_dict = dict

	save_data.location_id = CurrentLocationIdGameValue.new(dict.game_data.location_id)

	save_data.spawn_point_id = dict.game_data.spawn_point_id

	for key in dict.flags:

		var value = int(dict.flags[key])

		save_data.flags[key] = value

	for key in dict.counters:

		var value = int(dict.counters[key])

		save_data.counters[key] = value

	return save_data
extends Node




const SAVE_PATH = "user://save_data.json"



var active_save_data: SaveData



func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS





func create_new_save_data() -> SaveData:

	var save_data = SaveData.new()

	write_dict(save_data.to_dict())

	return save_data




func load_save_data() -> void:

	var dict = read_dict()

	if dict.is_empty():

		active_save_data = create_new_save_data()

	else:

		active_save_data = SaveData.from_dict(dict)





func write_save_data() -> void:

	var dict = active_save_data.to_dict()

	active_save_data.last_saved_dict = dict

	write_dict(dict)





func is_save_file_valid() -> bool:

	if not FileAccess.file_exists(SAVE_PATH):

		return false

	var dict = read_dict()

	if dict.is_empty():

		return false

	return true







func write_dict(dict: Dictionary) -> void:

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)

	file.store_string(JSON.stringify(dict, " "))

	file.close()





func read_dict() -> Dictionary:

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)

	if not file:

		return {}

	var json = JSON.new()

	json.parse(file.get_as_text())

	file.close()

	return json.data







func set_flag(key: String, value: Variant) -> void:

	if not active_save_data:

		return

	active_save_data.flags[key] = value



func get_flag(key: String, default: Variant = null) -> Variant:

	if active_save_data.flags.has(key):

		return active_save_data.flags[key]

	return default



func increment_counter(key: String) -> void:

	if not active_save_data:

		return

	if not active_save_data.counters.has(key):

		active_save_data.counters[key] = 0

	active_save_data.counters[key] += 1




func set_counter(key: String, value: int) -> void:

	if not active_save_data:

		return

	if not active_save_data.counters.has(key):

		active_save_data.counters[key] = 0

	active_save_data.counters.set(key, value)





func get_counter(key: String) -> int:

	if not active_save_data:

		return -1

	if active_save_data.counters.has(key):

		return active_save_data.counters[key]

	return -1
extends Node




var location_scene_registry: Dictionary[String, PackedScene]



var main_menu: MainMenu

var world_root: Node2D

var current_location: Location



var cached_locations: Dictionary[String, Location]




func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS

	Game.game_state_changed.connect(_on_game_state_changed)

	world_root = get_tree().get_first_node_in_group("world_root")

	load_location_scenes()
















func open_location(location: Location, cache_current:= false) -> void:

	if current_location:

		close_location(cache_current)

	main_menu.hide()

	current_location = location

	world_root.add_child(location)

	location.open()




func close_location(cache:= false) -> void:

	if not current_location:

		return

	current_location.close()

	if cache:
		
		cached_locations[current_location.location_id] = current_location

	current_location.queue_free()







func get_location_scene(location_id: StringName) -> Location:
	
	if cached_locations.has(location_id):

		var location = cached_locations[location_id]

		cached_locations.erase(location_id)

		return location

	if location_scene_registry.has(location_id):

		var location = location_scene_registry[location_id].instantiate()

		location.location_id = location_id

		return location

	return null













func load_location_scenes() -> void:

	var dir = "res://main/locations/"

	for sub_dir in ResourceLoader.list_directory(dir):

		if sub_dir.ends_with("/"):

			var sub_dir_path = dir + sub_dir

			for sub_dir_dir in ResourceLoader.list_directory(sub_dir_path):

				if sub_dir_dir.ends_with(".tscn"):

					var path = sub_dir_path + sub_dir_dir

					var location_id = sub_dir + sub_dir_dir.trim_suffix(".tscn")

					var location_scene = load(path)

					location_scene_registry[location_id] = location_scene







func _on_game_state_changed(game_state: Game.GameState) -> void:

	match game_state:

		Game.GameState.MAIN_MENU:

			if current_location:

				close_location()

			main_menu.show()

		Game.GameState.ACTIVE:

			pass

		Game.GameState.CUTSCENE:

			pass
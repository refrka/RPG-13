extends Node


signal cutscene_ended

signal fade_in_complete

signal fade_out_complete


var location_scene_registry: Dictionary[String, PackedScene]

var cutscene_registry: Dictionary[StringName, Cutscene]



var root: Root

var main_menu: MainMenu

var world_root: Node2D

var current_location: Location



var cached_locations: Dictionary[String, Location]


var cutscene_root: Node2D

var current_cutscene: Cutscene

var current_cutscene_location: Location




var fade_out_command_set: CommandSet

var fade_in_command_set: CommandSet



func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS

	Game.game_state_changed.connect(_on_game_state_changed)

	root = get_tree().get_first_node_in_group("root")

	world_root = get_tree().get_first_node_in_group("world_root")

	cutscene_root = get_tree().get_first_node_in_group("cutscene_root")

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








func fade_out(data:= {}) -> void:

	fade_out_command_set = root.fade_out_command_set

	fade_out_command_set.all_commands_executed.connect(_on_fade_out_complete, CONNECT_ONE_SHOT)

	fade_out_command_set.execute_all(data)



func fade_in(data:= {}) -> void:

	fade_in_command_set = root.fade_in_command_set

	fade_in_command_set.all_commands_executed.connect(_on_fade_in_complete, CONNECT_ONE_SHOT)

	fade_in_command_set.execute_all(data)





func _on_fade_out_complete() -> void:

	fade_out_complete.emit()



func _on_fade_in_complete() -> void:

	fade_in_complete.emit()





func run_cutscene(cutscene: Cutscene) -> void:

	var cutscene_location = get_location_scene(cutscene.location_id)

	open_cutscene_location(cutscene_location)

	Game.set_game_state(Game.GameState.CUTSCENE)

	cutscene.cutscene_ended.connect(end_cutscene)

	current_cutscene = cutscene

	cutscene.run()



func end_cutscene() -> void:

	cutscene_ended.emit()

	Data.set_flag(current_cutscene.cutscene_id, 1)

	current_cutscene = null

	close_cutscene_location()

	Game.set_game_state(Game.GameState.ACTIVE)




func open_cutscene_location(location: Location) -> void:

	if cutscene_root.get_children().size() > 0:

		for child in cutscene_root.get_children():

			child.queue_free()

	cutscene_root.add_child(location)

	current_cutscene_location = location



func close_cutscene_location() -> void:

	current_cutscene_location.queue_free()

	current_cutscene_location = null













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






func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("end_cutscene") and Inputs.is_action_allowed("end_cutscene"):

		if current_cutscene:

			current_cutscene.end()






func _on_game_state_changed(game_state: Game.GameState) -> void:

	match game_state:

		Game.GameState.MAIN_MENU:

			if current_location:

				close_location()

			main_menu.show()

		Game.GameState.ACTIVE:

			world_root.show()

		Game.GameState.CUTSCENE:

			world_root.hide()



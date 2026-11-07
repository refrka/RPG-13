extends Node


signal game_state_changed(new_state: GameState)



enum GameState {

	MAIN_MENU,

	ACTIVE,

	CUTSCENE,

}



var game_state: GameState

var player: Player:

	get:

		if not player:

			player = get_tree().get_first_node_in_group("player")

		if not player:

			player = load("res://main/entities/player.tscn").instantiate()

			add_child(player)

		return player







func _ready() -> void:

	if not Data.is_save_file_valid():

		Data.create_new_save_data()









func start() -> void:

	Data.load_save_data()

	set_game_state(GameState.ACTIVE)

	var location = Scenes.get_location_scene(Data.active_save_data.last_saved_dict.game_data.location_id)

	Scenes.open_location(location)

	location.spawn_player(Data.active_save_data.spawn_point_id)



func reset() -> void:

	Data.create_new_save_data()



func quit() -> void:

	get_tree().quit()



func exit() -> void:

	set_game_state(GameState.MAIN_MENU)




func save() -> void:

	Data.active_save_data.last_save_unix = Time.get_unix_time_from_system()

	Data.write_save_data()



func load_last() -> void:

	Scenes.close_location()

	start()





func load_location(location_id: StringName) -> Location:

	if game_state != Game.GameState.ACTIVE:

		return null

	var location = Scenes.get_location_scene(location_id)

	Scenes.open_location(location)

	return location



func change_location(location_id: StringName, spawn_point_id: StringName) -> void:

	var location = load_location(location_id)

	location.spawn_player(spawn_point_id)



func set_game_state(_game_state: GameState) -> void:

	game_state = _game_state

	game_state_changed.emit(game_state)






func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("quicksave"):

		save()
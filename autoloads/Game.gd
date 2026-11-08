extends Node


signal game_state_changed(new_state: GameState)



enum GameState {

	MAIN_MENU,

	ACTIVE,

	CUTSCENE,

	PAUSED,

}



var game_state: GameState

var player: Player:

	get:

		if not player:

			player = get_tree().get_first_node_in_group("player")

		if not player:

			player = load("res://main/entities/player.tscn").instantiate()

			player.initialize()

			add_child(player)

		return player

var pause_count:= 0






func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS
	
	if not Data.is_save_file_valid():

		Data.create_new_save_data()









func start() -> void:

	Events.fire(GameStartingEvent)

	Data.load_save_data()

	set_game_state(GameState.ACTIVE)

	var location = Scenes.get_location_scene(Data.active_save_data.last_saved_dict.game_data.location_id)

	Scenes.open_location(location)

	location.spawn_player(Data.active_save_data.spawn_point_id)

	Game.player.activate()

	Events.fire(GameStartedEvent)



func reset() -> void:

	Data.create_new_save_data()



func quit() -> void:

	get_tree().quit()



func exit() -> void:

	Events.fire(GameExitingEvent)

	set_game_state(GameState.MAIN_MENU)

	Events.fire(GameExitedEvent)




func save() -> void:

	Data.active_save_data.last_save_unix = Time.get_unix_time_from_system()

	Data.write_save_data()



func load_last() -> void:

	Scenes.close_location()

	start()






func pause() -> void:

	get_tree().paused = true

	set_game_state(GameState.PAUSED)



func unpause() -> void:

	get_tree().paused = false

	set_game_state(GameState.ACTIVE)




func request_pause() -> void:

	pause_count += 1

	if pause_count > 0 and not is_paused():

		pause()



func request_unpause() -> void:

	pause_count -= 1

	if pause_count <= 0 and is_paused():

		unpause()




func is_paused() -> bool:

	return get_tree().paused and game_state == GameState.PAUSED





func load_location(location_id: StringName) -> Location:

	if game_state != Game.GameState.ACTIVE:

		return null

	var location = Scenes.get_location_scene(location_id)

	Scenes.open_location(location)

	return location



func change_location(location_id: StringName, spawn_point_id: StringName) -> void:

	var location = load_location(location_id)

	location.spawn_player(spawn_point_id)

	player.activate()



func set_game_state(_game_state: GameState) -> void:

	game_state = _game_state

	game_state_changed.emit(game_state)





func is_active() -> bool:

	return game_state == GameState.ACTIVE





func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("quicksave"):

		save()
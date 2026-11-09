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

			add_child(player)

		return player

var pause_count:= 0


var camera: GameCamera:

	get:

		if not camera:

			camera = get_tree().get_first_node_in_group("game_camera")

		return camera







func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS
	
	if not Data.is_save_file_valid():

		Data.create_new_save_data()







func start() -> void:
	
	Scenes.main_menu.hide()

	Events.fire(GameStartingEvent)

	Data.load_save_data()

	var location = Scenes.get_location_scene(Data.active_save_data.last_saved_dict.game_data.location_id)

	Scenes.open_location(location)

	player.initialize()

	location.spawn_player(Data.active_save_data.spawn_point_id)

	AttachCameraToPlayerCommand.run()

	Scenes.fade_in_complete.connect(_on_start_fade_in_complete.bind(location), CONNECT_ONE_SHOT)

	Scenes.fade_in({ "rate": 1.0 })










func reset() -> void:

	Data.create_new_save_data()



func quit() -> void:

	get_tree().quit()



func exit() -> void:

	Events.fire(GameExitingEvent)

	DetachCameraFromPlayerCommand.run()
	
	player.queue_free()

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





func load_location(location_id: StringName) -> Location:

	if game_state != Game.GameState.ACTIVE:

		return null

	var location = Scenes.get_location_scene(location_id)

	Scenes.open_location(location)

	return location



func change_location(location_id: StringName, spawn_point_id: StringName) -> void:

	if Scenes.current_location and Scenes.current_location.location_id == location_id:

		return

	Scenes.fade_out_complete.connect(_on_location_change_fade_out_complete.bind(location_id, spawn_point_id), CONNECT_ONE_SHOT)

	Scenes.fade_out({ "rate": 1.0 })











func set_game_state(_game_state: GameState) -> void:

	game_state = _game_state

	game_state_changed.emit(game_state)











func is_paused() -> bool:

	return get_tree().paused and game_state == GameState.PAUSED



func is_active() -> bool:

	return game_state == GameState.ACTIVE



func is_fading() -> bool:

	if Scenes.fade_in_command_set and Scenes.fade_in_command_set.is_executing():

		return true

	if Scenes.fade_out_command_set and Scenes.fade_out_command_set.is_executing():

		return true

	return false








func _on_location_change_fade_out_complete(location_id: StringName, spawn_point_id: StringName) -> void:

	var location = load_location(location_id)

	if location.open_command_set:

		location.open_command_set.all_commands_executed.connect(_on_open_command_set_step_complete.bind(location, spawn_point_id), CONNECT_ONE_SHOT)

		location.open_command_set.execute_all()

	else:

		_on_open_command_set_step_complete(location, spawn_point_id)





func _on_open_command_set_step_complete(location: Location, spawn_point_id: StringName) -> void:

	location.spawn_player(spawn_point_id)

	Scenes.fade_in_complete.connect(_on_location_change_fade_in_complete.bind(location), CONNECT_ONE_SHOT)

	Scenes.fade_in({ "rate": 1.0 })





func _on_location_change_fade_in_complete(location: Location) -> void:

	location.activate()




func _on_start_fade_in_complete(location: Location) -> void:

	set_game_state(GameState.ACTIVE)

	location.activate()

	if location.open_command_set:

		location.open_command_set.execute_all()

	Events.fire(GameStartedEvent)

	




func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("quicksave") and Inputs.is_action_allowed("quicksave"):

		save()





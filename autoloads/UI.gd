extends Node




var game_menu: GameMenu



func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS

	Game.game_state_changed.connect(_on_game_state_changed)

	game_menu = get_tree().get_first_node_in_group("game_menu")










func _on_game_state_changed(_game_state: Game.GameState) -> void:

	game_menu.visible = false





func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("game_menu") and Inputs.is_action_allowed("game_menu"):

		if game_menu.visible:

			game_menu.hide()

		else:

			game_menu.show()
extends Node


signal overlay_stack_emptied


var game_menu: GameMenu


var overlay_registry: Dictionary[Script, Overlay]

var overlay_stack: Array[Overlay]




func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS

	Game.game_state_changed.connect(_on_game_state_changed)

	game_menu = get_tree().get_first_node_in_group("game_menu")





func register_overlay(overlay: Overlay) -> void:

	var script = overlay.get_script()

	overlay_registry[script] = overlay

	overlay.tree_exiting.connect(_on_overlay_exiting_tree)

	overlay.deactivate()



func unregister_overlay(overlay: Overlay) -> void:

	var script = overlay.get_script()

	if overlay_registry.has(script):

		overlay_registry.erase(script)







func add_overlay_to_stack(overlay: Overlay) -> void:

	overlay_stack.append(overlay)

	if overlay.request_pause:

		Game.request_pause()

	overlay.activate()




func remove_overlay_from_stack(overlay: Overlay) -> void:

	overlay_stack.erase(overlay)

	if overlay.request_pause:

		Game.request_unpause()

	if overlay_stack.is_empty():

		overlay_stack_emptied.emit()

	overlay.deactivate()



func get_overlay(overlay_script: Script) -> Overlay:

	if overlay_registry.has(overlay_script):

		return overlay_registry[overlay_script]

	return null




func _on_game_state_changed(_game_state: Game.GameState) -> void:

	game_menu.visible = false




func _on_overlay_exiting_tree(overlay: Overlay) -> void:

	remove_overlay_from_stack(overlay)




func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("game_menu") and Inputs.is_action_allowed("game_menu"):

		if game_menu.active:

			remove_overlay_from_stack(game_menu)

		else:

			add_overlay_to_stack(game_menu)

	if event.is_action_pressed("profile") and Inputs.is_action_allowed("profile"):

		var overlay = get_overlay(ProfileOverlay)

		if overlay.active:

			remove_overlay_from_stack(overlay)
			
		else:
			
			add_overlay_to_stack(overlay)




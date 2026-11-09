extends Node



var input_configs: Array[InputConfig]

var current_input_config: InputConfig


var enabled_actions: Array[StringName]

var disabled_actions: Array[StringName]





func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS

	Game.game_state_changed.connect(_on_game_state_changed)






func set_input_config(input_config: InputConfig) -> void:

	current_input_config = input_config




func is_action_allowed(action: StringName) -> bool:

	if disabled_actions.has(action) or (not enabled_actions.has(action) and not current_input_config.allowed_actions.has(action)):

		return false

	return true




func enable_action(action: StringName) -> void:

	if not current_input_config.allowed_actions.has(action):

		if not enabled_actions.has(action):

			enabled_actions.append(action)

	if disabled_actions.has(action):

		disabled_actions.erase(action)




func disable_action(action: StringName) -> void:

	if current_input_config.allowed_actions.has(action):

		if not disabled_actions.has(action):

			disabled_actions.append(action)

	if enabled_actions.has(action):

		enabled_actions.erase(action)





func get_allowed_actions() -> Array:

	var allowed = enabled_actions.duplicate()

	for action in current_input_config.allowed_actions:

		if not disabled_actions.has(action) and not allowed.has(action):

			allowed.append(action)

	return current_input_config.allowed_actions






func _on_game_state_changed(game_state: Game.GameState) -> void:

	for config in input_configs:

		if config.game_state == game_state:

			set_input_config(config)







func _input(event: InputEvent) -> void:

	if event is InputEventKey:

		if get_viewport().gui_get_focus_owner() is LineEdit:

			return

		for action in get_allowed_actions():

			var events = InputMap.action_get_events(action)

			for _event in events:

				if _event.physical_keycode == event.physical_keycode:

					return

		get_viewport().set_input_as_handled()
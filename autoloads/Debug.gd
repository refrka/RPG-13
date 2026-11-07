extends Node



var debug_screen: DebugScreen


var command_option_registry: Array[Script]




func _ready() -> void:

	debug_screen = get_tree().get_first_node_in_group("debug_screen")

	for location_id in Scenes.location_scene_registry:

		var button = Button.new()

		button.text = location_id

		debug_screen.location_list.add_child(button)

		button.pressed.connect(_on_location_selected.bind(location_id))

	var path = "res://main/commands/"

	for dir in ResourceLoader.list_directory(path):

		var dir_path = path + dir

		var object = load(dir_path)

		if object.get_base_script() == Command:

			var command_class_name = object.get_global_name()

			debug_screen.command_option_list.add_item(command_class_name)

			command_option_registry.append(object)












func _on_location_selected(location_id: StringName) -> void:

	Game.change_location(location_id, "start_spawn")








func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("debug"):

		debug_screen.visible = not debug_screen.visible
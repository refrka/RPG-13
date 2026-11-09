extends Node




var item_registry: Dictionary[StringName, Item]





func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS

	load_item_registry()








func drop_pickup(item: Item, target_position: Vector2) -> Pickup:

	var pickup = Pickup.new_pickup(item)

	return pickup










func get_item(item_id: StringName) -> Item:

	if item_registry.has(item_id):

		return item_registry[item_id]

	return null






func load_item_registry() -> void:

	var dirs = ["res://main/items/"]

	while not dirs.is_empty():

		var dir = dirs.pop_back()

		for dir_name in ResourceLoader.list_directory(dir):

			var path = dir + dir_name
			
			if dir_name.ends_with("/"):

				dirs.append(path)

			elif dir_name.ends_with(".tres"):

				var item = load(path) as Item

				item_registry[item.item_id] = item


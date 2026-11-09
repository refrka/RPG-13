class_name Pickup extends Entity


var item: Item


func load_item(_item: Item) -> void:

	item = _item

	body_sprite.texture = _item.icon_texture

	body_sprite.offset.y = -_item.icon_texture.get_height() / 2




static func new_pickup(item: Item) -> Pickup:

	var pickup = load("res://main/entities/pickup.tscn").instantiate()

	pickup.load_item(item)

	return pickup
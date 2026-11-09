class_name ItemData extends Resource


@export var item: Item

@export var durability:= 1.0




func to_dict() -> Dictionary:

	return {

		"item_id": item.item_id,

		"durability": durability,

	}





static func from_dict(dict: Dictionary) -> ItemData:

	var item_data = ItemData.new()

	item_data.durability = dict.durability

	return item_data
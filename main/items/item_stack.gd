class_name ItemStack extends Resource


signal stack_updated

signal stack_emptied


@export var item: Item

@export var item_data: ItemData

@export var count: int

var inventory_index: int



func clear() -> void:

	set_item(null)

	set_count(0)



func set_stack(_item: Item, _count: int) -> void:

	set_item(_item)

	set_count(_count)



func set_item(_item: Item) -> void:

	item = _item

	stack_updated.emit()



func set_data(_item_data: ItemData) -> void:

	item_data = _item_data

	set_count(1)



func set_count(_count: int) -> void:

	count = _count

	stack_updated.emit()

	if is_empty():

		stack_emptied.emit()



func add_amount(amount: int) -> int:

	var remaining = amount

	var space = item.max_stack - count

	var new_count = count

	if space >= remaining:

		new_count = count + remaining

		remaining = 0

	else:

		new_count = item.max_stack

		remaining -= space

	set_count(new_count)

	return remaining




func remove_amount(amount: int) -> int:

	var remaining = amount

	var new_count = count

	if count >= remaining:

		new_count -= remaining

		remaining = 0

	else:

		new_count = 0

		remaining -= count

	set_count(new_count)

	return remaining





func can_merge(item_stack: ItemStack) -> bool:

	if item != item_stack.item:

		return false

	return true



func is_full() -> bool:

	if item_data:

		return count == 1

	if is_empty():

		return false

	return count < item.max_stack



func is_empty() -> bool:

	return count <= 0 or item == null



func merge(item_stack: ItemStack) -> void:

	var remaining = add_amount(item_stack.count)

	item_stack.set_count(remaining)




func swap(item_stack: ItemStack) -> void:

	var temp_item = item_stack.item

	var temp_count = item_stack.count

	item_stack.set_stack(item, count)

	set_stack(temp_item, temp_count)





static func new_stack(_item: Item, _item_data: ItemData = null, _count:= 1) -> ItemStack:

	if _item is Equipment and _item_data == null:

		_item_data = ItemData.new()

		_item_data.item = _item

	if _item_data:

		_count = 1

	var stack:= ItemStack.new()

	stack.item = _item

	stack.item_data = _item_data

	stack.count = _count

	return stack






func to_dict() -> Dictionary:

	var dict = {}

	dict["item_id"] = item.item_id

	dict["count"] = count

	if item_data:

		dict["item_data"] = item_data.to_dict()

	return dict
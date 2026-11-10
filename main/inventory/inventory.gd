class_name Inventory extends Resource

signal index_updated(index: int, stack: ItemStack)

@export var stacks: Array[ItemStack]

@export var size:= 9

var entity: Entity




func initialize(_entity: Entity) -> void:

	entity = _entity

	resize(size)

	if entity.entity_def.initial_inventory and not entity is Player:

		merge_inventory(entity.entity_def.initial_inventory)

	for i in range(size):

		var stack = get_item_stack(i)

		if stack != null:

			stack.inventory_index = i

			stack.stack_emptied.connect(_on_item_stack_emptied.bind(i))





func clear() -> void:

	stacks.clear()

	resize()





func add_items(item: Item, amount:= 1) -> int:

	var remaining = amount

	for stack in get_stacks_with_item(item):

		remaining = stack.add_amount(remaining)

	var empty_index = get_first_empty_index()

	while remaining > 0 and empty_index != -1:

		var stack = ItemStack.new_stack(item, null, remaining)

		remaining -= stack.count

		set_stack_index(empty_index, stack)

		empty_index = get_first_empty_index()

	return remaining



func resize(_size:= -1) -> void:

	if _size < 0:

		_size = size

	stacks.resize(_size)




func set_stack_index(index: int, stack: ItemStack) -> void:

	if stacks.size() - 1 >= index:

		stacks[index] = stack

		if stack != null:

			stack.inventory_index = index

		index_updated.emit(index, stack)



func get_item_stack(index: int) -> ItemStack:

	if stacks.size() - 1 >= index:

		return stacks[index]
	
	return null




func get_stacks_with_item(item: Item) -> Array:

	var _stacks = []

	for stack in stacks:

		if stack != null and stack.item == item:

			_stacks.append(stack)

	return _stacks




func get_first_empty_index() -> int:

	for i in range(stacks.size()):

		var stack = get_item_stack(i)
		
		if stack == null:

			return i

	return -1






func merge_inventory(inventory: Inventory) -> void:

	for i in range(inventory.stacks.size()):

		var merged_stack = inventory.get_item_stack(i)

		if merged_stack != null:

			var matched_stacks = get_stacks_with_item(merged_stack.item)

			if matched_stacks.is_empty():

				var empty_index = get_first_empty_index()

				if empty_index != -1:

					set_stack_index(empty_index, merged_stack)

			else:

				var remaining = merged_stack.count

				while remaining > 0 and not matched_stacks.is_empty():

					var to_stack = matched_stacks.pop_front()

					remaining = to_stack.add_amount(remaining)

					if remaining == 0:

						merged_stack.clear()

			if merged_stack.is_empty():

				inventory.set_stack_index(i, null)

	








func _on_item_stack_emptied(index: int) -> void:

	var stack = get_item_stack(index)

	set_stack_index(index, null)

	if stack:

		stack.free()













func to_dict() -> Dictionary:

	var dict = {}

	dict["items"] = []

	for stack in stacks:

		if stack:

			dict.items.append(stack.to_dict())

		else:

			dict.items.append({})

	return dict




func load_dict(dict: Dictionary) -> void:

	for stack_dict in dict.items:

		if stack_dict.is_empty():

			stacks.append(null)

		else:

			var stack = ItemStack.from_dict(stack_dict)

			stacks.append(stack)
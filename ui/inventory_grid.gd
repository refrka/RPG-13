class_name InventoryGrid extends GridContainer


@onready var item_slot_scene:= preload("res://ui/item_slot.tscn")



var inventory: Inventory




func load_inventory(_inventory: Inventory) -> void:

	clear()

	inventory = _inventory

	inventory.index_updated.connect(_on_inventory_index_updated)

	for stack in inventory.stacks:

		var item_slot = add_item_slot()

		item_slot.set_stack(stack)



func add_item_slot() -> ItemSlot:

	var item_slot = item_slot_scene.instantiate()

	item_slot.selected_state_changed.connect(_on_slot_selected_state_changed)

	item_slot.hovered_state_changed.connect(_on_slot_hovered_state_changed)

	item_slot.stack_updated.connect(_on_slot_stack_updated.bind(item_slot))

	add_child(item_slot)

	return item_slot





func clear() -> void:

	for child in get_children():

		child.queue_free()








func _on_inventory_index_updated(index: int, stack: ItemStack) -> void:

	var item_slot = get_child(index)

	if item_slot.stack != stack:

		item_slot.set_stack(stack)





func _on_slot_selected_state_changed(state: bool) -> void:

	pass



func _on_slot_hovered_state_changed(state: bool) -> void:

	pass



func _on_slot_stack_updated(slot: ItemSlot) -> void:

	var index = slot.get_index()

	inventory.set_stack_index(index, slot.stack)
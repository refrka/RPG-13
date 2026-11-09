class_name CursorSlot extends ItemSlot



var copied_slot: ItemSlot




func _ready() -> void:

	UI.cursor_slot = self





func copy_slot(slot: ItemSlot) -> void:

	copied_slot = slot

	copied_slot.visibility_changed.connect(_on_copied_slot_visibility_changed)

	set_stack(slot.stack)





func drop_slot() -> void:

	copied_slot.set_selected(false)

	copied_slot.visibility_changed.disconnect(_on_copied_slot_visibility_changed)

	copied_slot = null

	set_stack(null)

	global_position = Vector2.ZERO





func _on_copied_slot_visibility_changed() -> void:

	if not copied_slot.is_visible_in_tree():

		drop_slot()





func _process(_delta: float) -> void:

	if not is_empty():

		global_position = get_global_mouse_position()



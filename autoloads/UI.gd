extends Node


signal overlay_stack_emptied


var game_menu: GameMenu


var overlay_registry: Dictionary[Script, Overlay]

var overlay_stack: Array[Overlay]




var cursor_slot: CursorSlot


var multi_hover_enabled:= false

var hovered_item_slots: Array

var multi_select_enabled:= false

var selected_item_slots: Array




var bg_rect: ColorRect

var fg_rect: ColorRect




func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS

	Game.game_state_changed.connect(_on_game_state_changed)

	game_menu = get_tree().get_first_node_in_group("game_menu")

	bg_rect = get_tree().get_first_node_in_group("bg_rect")

	fg_rect = get_tree().get_first_node_in_group("fg_rect")

	Events.subscribe(GameExitingEvent, _on_game_exiting)





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
















func handle_slot_input(item_slot: ItemSlot, event: InputEvent) -> void:
	
	if multi_select_enabled:

		pass

	else:

		match [item_slot.is_empty(), cursor_slot.is_empty(), event.button_index, event.is_pressed()]:

			[false, true, 1, true]:

				cursor_slot.copy_slot(item_slot)

				item_slot.set_selected(true)

			[true, true, 1, true]:

				pass

			[false, false, 1, true]:

				if cursor_slot.copied_slot == item_slot:

					cursor_slot.drop_slot()

				else:

					item_slot.stack.swap(cursor_slot.stack)

			[true, false, 1, true]:

				item_slot.set_stack(cursor_slot.stack)

				cursor_slot.copied_slot.set_stack(null)

				cursor_slot.drop_slot()

			[_, false, 2, true]:

				cursor_slot.drop_slot()









func set_multi_hover_enabled(state: bool) -> void:

	multi_hover_enabled = state

	if not multi_hover_enabled:

		for slot in hovered_item_slots:

			slot.set_hovered(false)

		hovered_item_slots.clear()




func set_multi_select_enabled(state: bool) -> void:

	multi_select_enabled = state

	if not multi_select_enabled:

		for slot in selected_item_slots:

			slot.set_selected(false)

		selected_item_slots.clear()





func hover_item_slot(item_slot: ItemSlot, state: bool) -> void:

	if state == true:

		hovered_item_slots.append(item_slot)

	else:

		if hovered_item_slots.has(item_slot):

			hovered_item_slots.erase(item_slot)



func select_item_slot(item_slot: ItemSlot, state: bool) -> void:

	if state == true:

		selected_item_slots.append(item_slot)

	else:

		if selected_item_slots.has(item_slot):

			selected_item_slots.erase(item_slot)




func is_slot_hovered(item_slot: ItemSlot) -> bool:

	return hovered_item_slots.has(item_slot)



func is_slot_selected(item_slot: ItemSlot) -> bool:

	return selected_item_slots.has(item_slot)



















func _on_game_state_changed(_game_state: Game.GameState) -> void:

	game_menu.visible = false




func _on_overlay_exiting_tree(overlay: Overlay) -> void:

	remove_overlay_from_stack(overlay)




func _on_game_exiting(_event: Event) -> void:

	if not overlay_stack.is_empty():

		for overlay in overlay_stack:

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

	if event is InputEventMouseButton and event.button_index == 2 and not cursor_slot.is_empty():

		cursor_slot.drop_slot()




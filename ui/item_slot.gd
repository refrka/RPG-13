class_name ItemSlot extends MarginContainer





signal selected_state_changed(state: bool)

signal hovered_state_changed(state: bool)

signal stack_updated



@export var panel: PanelContainer

@export var icon_texture_rect: TextureRect

@export var count_label: Label

@export_group("StyleBoxes")

@export var default_stylebox: StyleBoxFlat

@export var hovered_stylebox: StyleBoxFlat

@export var selected_stylebox: StyleBoxFlat

@export var hovered_selected_stylebox: StyleBoxFlat

@export var hover_enabled:= true

@export var gui_input_enabled:= true

@export var deselect_enabled:= true


var stack: ItemStack

var hovered:= false

var selected:= false




func _ready() -> void:

	if hover_enabled:

		connect_hover()

	if gui_input_enabled:

		connect_gui_input()

		



func connect_hover() -> void:

	mouse_entered.connect(_on_mouse_entered)

	mouse_exited.connect(_on_mouse_exited)




func disconnect_hover() -> void:

	mouse_entered.disconnect(_on_mouse_entered)

	mouse_exited.disconnect(_on_mouse_exited)
	



func connect_gui_input() -> void:

	gui_input.connect(_on_gui_input)



func disconnect_gui_input() -> void:

	gui_input.disconnect(_on_gui_input)




func set_stack(_stack: ItemStack) -> void:

	if stack:

		stack.stack_updated.disconnect(_on_stack_updated)

	stack = _stack

	if stack:

		stack.stack_updated.connect(_on_stack_updated)

	update_visuals()

	stack_updated.emit()






func set_hovered(state: bool) -> void:

	hovered = state

	UI.hover_item_slot(self, state)

	hovered_state_changed.emit(hovered)

	update_visuals()
	





func set_selected(state: bool) -> void:

	selected = state

	UI.select_item_slot(self, state)

	selected_state_changed.emit(selected)

	update_visuals()






func is_empty() -> bool:

	if stack == null:

		return true

	return stack.is_empty()







func _on_gui_input(event: InputEvent) -> void:

	if event is InputEventMouseButton:

		UI.handle_slot_input(self, event)
			





func _on_mouse_entered() -> void:

	set_hovered(true)



func _on_mouse_exited() -> void:

	set_hovered(false)




func _on_stack_updated() -> void:

	update_visuals()






func update_visuals() -> void:

	icon_texture_rect.texture = null

	icon_texture_rect.modulate.v = 1.0 if not selected else 0.0

	var stylebox = default_stylebox

	match [hovered, selected]:

		[true, false]:

			stylebox = hovered_stylebox

		[false, true]:

			stylebox = selected_stylebox

		[true, true]:

			stylebox = hovered_selected_stylebox

	panel.add_theme_stylebox_override("panel", stylebox)

	if not is_empty():

		icon_texture_rect.texture = stack.item.icon_texture
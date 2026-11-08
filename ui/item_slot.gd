class_name ItemSlot extends MarginContainer





@export var panel: PanelContainer

@export var icon_texture_rect: TextureRect

@export var count_label: Label

@export_group("StyleBoxes")

@export var default_stylebox: StyleBoxFlat

@export var hovered_stylebox: StyleBoxFlat

@export var selected_stylebox: StyleBoxFlat

@export var hovered_selected_stylebox: StyleBoxFlat



var stack: ItemStack

var hovered:= false

var selected:= false





func connect_hover() -> void:

	mouse_entered.connect(_on_mouse_entered)

	mouse_exited.connect(_on_mouse_exited)

	


func connect_gui_input() -> void:

	gui_input.connect(_on_gui_input)




func set_stack(_stack: ItemStack) -> void:

	stack = _stack






func update_visuals() -> void:

	pass


func update_count_label() -> void:

	pass


func update_texture() -> void:

	pass


func update_panel() -> void:

	pass





func _on_gui_input(event: InputEvent) -> void:

	if event is InputEventMouseButton:

		if event.is_pressed():

			pass





func _on_mouse_entered() -> void:

	pass



func _on_mouse_exited() -> void:

	pass
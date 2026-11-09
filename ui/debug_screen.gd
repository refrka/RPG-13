class_name DebugScreen extends MarginContainer


@onready var command_option_row_scene:= preload("res://ui/command_option_row.tscn")

@export var location_list: VBoxContainer

@export var data_list: VBoxContainer

@export var command_option_list: OptionButton

@export var add_value_button: Button

@export var clear_button: Button

@export var execute_command_button: Button


var current_command: Command



func _ready() -> void:

	add_value_button.pressed.connect(_on_add_value_pressed)

	clear_button.pressed.connect(_on_clear_pressed)

	execute_command_button.pressed.connect(_on_execute_command_pressed)



	


func _on_add_value_pressed() -> void:

	var row = command_option_row_scene.instantiate()

	data_list.add_child(row)





func _on_clear_pressed() -> void:

	for child in data_list.get_children():

		child.queue_free()

	var row = command_option_row_scene.instantiate()

	data_list.add_child(row)



func _on_execute_command_pressed() -> void:

	var command_index = command_option_list.get_selected_id()

	current_command = Debug.command_option_registry[command_index].new()

	var data:= {}

	for row in data_list.get_children():

		var row_data = row.get_data()

		for key in row_data:

			data[key] = row_data[key]

	current_command.execute(data)
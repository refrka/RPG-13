class_name CommandOptionRow extends HBoxContainer



@export var key_line_edit: LineEdit

@export var value_line_edit: LineEdit

@export var value_type: OptionButton






func get_data() -> Dictionary:

	var value_type_id = value_type.get_selected_id()

	var value: Variant = null

	match value_type.get_item_text(value_type_id):

		"STR":

			value = str(value_line_edit.text)

		"INT":

			if value_line_edit.text.is_valid_int():

				value = int(value_line_edit.text)

		"FLOAT":

			if value_line_edit.text.is_valid_float():

				value = float(value_line_edit.text)

		"BOOL":

			if value_line_edit.text.is_valid_int():

				value = bool(int(value_line_edit.text))

	return { key_line_edit.text: value }

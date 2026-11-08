class_name Overlay extends MarginContainer



@export var request_pause:= false



var active:= false



func _ready() -> void:

	UI.register_overlay(self)





func activate() -> void:

	active = true

	show()



func deactivate() -> void:

	active = false

	hide()
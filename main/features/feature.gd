class_name Feature extends Node2D


@export var feature_id: StringName


var initialized:= false

var active:= false



func initialize() -> void:

	if initialized:

		return

	initialized = true





func activate() -> void:

	active = true




func deactivate() -> void:

	active = false
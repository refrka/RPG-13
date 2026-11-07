class_name NodeScript extends Node


var parent_node: Node

var process_callbacks: Array

var physics_callbacks: Array

var active:= false

var duration:= -1.0

var timer:= -1.0



func _enter_tree() -> void:

	activate()

	parent_node = get_parent()

	timer = duration



func add_process_callback(callback: Callable) -> void:

	process_callbacks.append(callback)



func add_physics_callback(callback: Callable) -> void:

	physics_callbacks.append(callback)




func activate() -> void:

	active = true



func deactivate() -> void:

	active = false




func _process(delta: float) -> void:

	if not active:

		return

	for callback in process_callbacks:

		if callback.is_valid():

			callback.call(delta, parent_node)

	if timer > 0.0:

		timer -= delta

		if timer <= 0.0:

			queue_free()




func _physics_process(delta: float) -> void:

	if not active:

		return

	for callback in physics_callbacks:

		if callback.is_valid():

			callback.call(delta, parent_node)





static func new_script(_process_callbacks:= [], _physics_callbacks:= [], _duration:= -1.0) -> NodeScript:

	var node_script = NodeScript.new()

	node_script.process_callbacks.append_array(_process_callbacks)

	node_script.physics_callbacks.append_array(_physics_callbacks)

	node_script.duration = _duration

	return node_script
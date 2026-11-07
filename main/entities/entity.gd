class_name Entity extends PhysicsBody2D



@export var entity_def: EntityDef

@export var component_root: Node


var initialized:= false

var active:= false




var unique_id: int

var entities_index: int






func initialize() -> void:

	if initialized:

		return

	initialized = true

	Entities.register_entity(self)







func activate() -> void:

	active = true



func deactivate() -> void:

	active = false
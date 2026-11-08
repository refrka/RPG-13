class_name Entity extends PhysicsBody2D


@export var authored_id:= -1

@export var disabled:= false

@export var entity_def: EntityDef

@export var inventory:= Inventory.new()

@export var component_root: Node


var initialized:= false

var active:= false

var location: Location


var unique_id:= -1

var entities_index:= -1





func initialize() -> void:

	if initialized:

		return

	initialized = true

	Entities.register_entity(self)

	component_root.get_children().map(func(c): c.initialize(self))

	if inventory:

		inventory = inventory.duplicate(true)

		inventory.initialize(self)




func enable() -> void:

	disabled = false



func disable() -> void:

	disabled = true

	deactivate()




func activate() -> void:

	if disabled:

		return

	active = true

	component_root.get_children().map(func(c): c.activate())



func deactivate() -> void:

	active = false

	component_root.get_children().map(func(c): c.deactivate())

















func generate_authored_id() -> void:

	var id = randi()

	while not is_authored_id_available(id):

		id = randi()

	authored_id = id




func is_authored_id_available(id: int) -> bool:

	var ysort_root = get_parent().get_parent()

	if ysort_root == null:

		return true

	for child in ysort_root.get_child(0).get_children():

		if child is Entity and child.authored_id == id:

			return false

	for child in ysort_root.get_child(1).get_children():

		if child is Entity and child.authored_id == id:

			return false

	return true
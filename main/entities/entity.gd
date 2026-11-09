class_name Entity extends PhysicsBody2D


@export var persist:= false

@export var authored_id:= -1

@export var disabled:= false

@export var entity_def: EntityDef

@export var inventory:= Inventory.new()

@export var component_root: Node

@export var body_sprite: Sprite2D

@export var shadow_sprite: Sprite2D

@export var anim_player: AnimationPlayer

@export var center_marker: Marker2D



var sensors: Array[Sensor]


var initialized:= false

var active:= false

var location: Location


var unique_id:= -1

var entities_index:= -1





func _init() -> void:

	if not child_entered_tree.is_connected(_on_child_entered_entity_tree):

		child_entered_tree.connect(_on_child_entered_entity_tree)




func _on_child_entered_entity_tree(child: Node) -> void:

	if child is Sensor:

		register_sensor(child)





func initialize() -> void:

	if initialized:

		return

	initialized = true

	Entities.register_entity(self)

	sensors.map(func(s): s.initialize(self))

	if component_root:

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

	if component_root:

		component_root.get_children().map(func(c): c.activate())

	sensors.map(func(s): s.activate())



func deactivate() -> void:

	active = false

	if component_root:

		component_root.get_children().map(func(c): c.deactivate())

	sensors.map(func(s): s.deactivate())

















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






func register_sensor(sensor: Sensor) -> void:

	if not sensors.has(sensor):

		sensors.append(sensor)







func create_reference() -> EntityRef:

	var entity_ref = EntityRef.new()

	entity_ref.authored_id = authored_id

	entity_ref.unique_id = unique_id

	entity_ref.entity_def = entity_def

	entity_ref.entity_id = entity_def.entity_id

	return entity_ref




func get_component(component_script: Script) -> Component:

	for component in component_root.get_children():

		if component.get_component_script() == component_script:

			return component

	return null



func get_interactable_component() -> InteractableComponent:

	for component in component_root.get_children():

		if component is InteractableComponent:

			return component

	return null



func is_interactable() -> bool:

	for component in component_root.get_children():

		if component is InteractableComponent:

			return true

	return false






func to_dict() -> Dictionary:

	var dict = {}

	if inventory:

		dict["inventory"] = inventory.to_dict()

	dict["components"] = {}

	for component in component_root.get_children():

		if component.has_method("to_dict"):

			dict.components[component.get_component_name()] = component.to_dict()

	return dict
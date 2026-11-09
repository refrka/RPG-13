class_name Location extends Node2D



@export_group("Node exports")

@export var nav_region: NavigationRegion2D

@export var ground_map: TileMapLayer

@export var data_map: TileMapLayer

@export var character_root: Node2D

@export var prop_root: Node2D

@export var pickup_root: Node2D

@export var feature_root: Node2D


@export_group("Location options")

@export var location_id: StringName

@export var open_command_set: CommandSet

var initialized:= false





func initialize() -> void:

	initialized = true

	for entity in character_root.get_children():

		entity.initialize()

		entity.location = self

		Entities.add_active_entity(entity)

	for entity in prop_root.get_children():

		entity.initialize()

		entity.location = self

		Entities.add_active_entity(entity)

	for feature in feature_root.get_children():

		feature.initialize()







func open() -> void:

	if not initialized:

		initialize()

	for entity in character_root.get_children():

		entity.generate_authored_id()





func close() -> void:

	for entity in character_root.get_children():

		entity.deactivate()

		character_root.remove_child(entity)

		entity.location = null

		Entities.remove_active_entity(entity)

	for entity in prop_root.get_children():

		entity.deactivate()

		prop_root.remove_child(entity)

		entity.location = null

		Entities.remove_active_entity(entity)

	for feature in feature_root.get_children():

		feature.deactivate()




func activate() -> void:

	for entity in character_root.get_children():

		entity.activate()

	for entity in prop_root.get_children():

		entity.activate()

	for feature in feature_root.get_children():

		feature.activate()





func spawn_player(spawn_point_id: StringName) -> void:

	var spawn_point = get_feature(spawn_point_id)

	if not spawn_point:

		return

	if Game.player.get_parent() == null:

		character_root.add_child(Game.player)

	elif Game.player.get_parent() != character_root:

		Game.player.reparent(character_root)

	Game.player.global_position = spawn_point.global_position

	Data.active_save_data.spawn_point_id = spawn_point_id





func add_entity(entity: Entity, target_position: Vector2) -> void:

	var root: Node2D = null

	if entity is Character:

		root = character_root

	elif entity is Prop:

		root = prop_root

	elif entity is Pickup:

		root = pickup_root

	root.add_child(entity)

	entity.global_position = target_position

	entity.location = self

	entity.tree_exited.connect(_on_entity_exited_tree.bind(entity))




func remove_entity(entity: Entity) -> void:

	entity.deactivate()

	if entity is Character and character_root.get_children().has(entity):

		character_root.remove_child(entity)

	elif entity is Prop and prop_root.get_children().has(entity):

		prop_root.remove_child(entity)

	entity.locaiton = null





func add_pickup(pickup: Pickup, target_position: Vector2) -> void:

	pickup_root.add_child(pickup)

	pickup.global_position = target_position

	




func get_feature(feature_id: StringName) -> Feature:

	for feature in feature_root.get_children():

		if feature.feature_id == feature_id:

			return  feature

	return null







func _on_entity_exited_tree(entity: Entity) -> void:

	Entities.remove_active_entity(entity)
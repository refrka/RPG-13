class_name Location extends Node2D



@export_group("Node exports")

@export var nav_region: NavigationRegion2D

@export var ground_map: TileMapLayer

@export var data_map: TileMapLayer

@export var character_root: Node2D

@export var prop_root: Node2D

@export var feature_root: Node2D


@export_group("Location options")

@export var location_id: StringName

@export var open_command_set: CommandSet

var initialized:= false





func initialize() -> void:

	initialized = true

	for entity in character_root.get_children():

		entity.initialize()

	for entity in prop_root.get_children():

		entity.initialize()

	for feature in feature_root.get_children():

		feature.initialize()







func open() -> void:

	if not initialized:

		initialize()

	for entity in character_root.get_children():

		entity.activate()

	for entity in prop_root.get_children():

		entity.activate()

	for feature in feature_root.get_children():

		feature.activate()

	if open_command_set:

		open_command_set.execute_all()





func close() -> void:

	for entity in character_root.get_children():

		entity.deactivate()

	for entity in prop_root.get_children():

		entity.deactivate()

	for feature in feature_root.get_children():

		feature.deactivate()







func spawn_player(spawn_point_id: StringName) -> void:

	var spawn_point = get_feature(spawn_point_id)

	if not spawn_point:

		return

	if not Game.player.get_parent() == character_root:

		Game.player.reparent(character_root)

	Game.player.global_position = spawn_point.global_position

	Data.active_save_data.spawn_point_id = spawn_point_id






func get_feature(feature_id: StringName) -> Feature:

	for feature in feature_root.get_children():

		if feature.feature_id == feature_id:

			return  feature

	return null
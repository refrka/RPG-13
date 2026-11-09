extends Node




var entity_registry: Dictionary[int, Entity]

var active_entities: Array[Entity]





func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS





func add_active_entity(entity: Entity) -> void:

	entity.entities_index = active_entities.size()

	active_entities.append(entity)



func remove_active_entity(entity: Entity) -> void:

	if active_entities.has(entity):

		var last = active_entities.back()

		if entity == last:

			active_entities.pop_back()

			return
		
		var index = entity.entities_index

		active_entities[index] = last

		last.entities_index = index

		active_entities.pop_back()

		entity.entities_index = -1





func register_entity(entity: Entity) -> void:

	if entity.authored_id != -1:

		entity.unique_id = entity.authored_id
	
	else:

		generate_unique_id(entity)

		entity_registry[entity.unique_id] = entity




func generate_unique_id(entity: Entity) -> void:

	var id = randi()

	while not is_unique_id_available(id):

		id = randi()

	entity.unique_id = id



func is_unique_id_available(id: int) -> bool:

	return not entity_registry.has(id)





func to_dict() -> Dictionary:

	var dict = {}

	for entity in active_entities:

		dict[entity.unique_id] = entity.to_dict()

	return dict
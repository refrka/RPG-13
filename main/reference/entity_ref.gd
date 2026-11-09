class_name EntityRef extends Resource


@export var entity_id: StringName

@export var authored_id:= -1

@export var entity_def: EntityDef

@export var unique_id:= -1








func matches(entity: Entity) -> bool:

	var passed:= true

	if entity_id != &"" and entity.entity_def.entity_id != entity_id:

		passed = false

	if authored_id != -1 and entity.authored_id != authored_id:

		passed = false

	if unique_id != -1 and entity.unique_id != unique_id:

		passed = false

	if entity_def and entity.entity_def != entity_def:

		passed = false

	return passed
class_name SpawnPointComponent extends InteractableComponent


@export var spawn_point_id: StringName



func start() -> void:

	SetPlayerSpawnPointCommand.run({ "spawn_point_id": spawn_point_id })

	interaction_ended.emit()
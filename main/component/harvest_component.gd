class_name HarvestComponent extends InteractableComponent



@export var loot_table: LootTable

@export var harvested_state_frames:= Vector2i(0, 1)

var harvested:= false





func can_interact() -> bool:

	return not harvested





func start() -> void:

	var loot = Loot.get_loot(loot_table, randf())

	for item in loot:

		var count = loot[item]

		for i in count:

			var pickup = Pickup.new_pickup(item)

			var target_pos = entity.global_position + Vector2(randf_range(-15.0, 15.0), randf_range(0.0, 15.0))

			Scenes.current_location.add_pickup(pickup, target_pos)

			pickup.initialize()

			pickup.activate()

	harvested = true

	entity.body_sprite.frame = harvested_state_frames.y

	interaction_ended.emit()





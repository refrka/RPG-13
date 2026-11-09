class_name HarvestComponent extends InteractableComponent



@export var loot_table: LootTable





func activate() -> void:

	super()

	var loot = Loot.get_loot(loot_table, randf())

	for item in loot:

		var count = loot[item]

		for i in count:

			var pickup = Pickup.new_pickup(item)

			var target_pos = entity.global_position + Vector2(randf_range(-30.0, 30.0), randf_range(-30.0, 30.0))

			Scenes.current_location.add_pickup(pickup, target_pos)
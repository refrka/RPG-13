extends Node





func get_drop_count(loot_table: LootTable, roll: float) -> int:

	var count:= 0

	for i in loot_table.drop_odds.size() - 1:

		if roll <= loot_table.drop_odds[i]:

			count += 1

	return count





func get_loot(loot_table: LootTable, roll: float) -> Dictionary[Item, int]:

	var loot: Dictionary[Item, int] = {}

	var count = get_drop_count(loot_table, roll)

	for i in count:

		var best_item: Item = null

		var best_odds:= 1.0

		for _item in loot_table.item_odds:

			var item_odds = loot_table.item_odds[_item]

			if roll <= item_odds and roll < best_odds:

				best_odds = item_odds

				best_item = _item

				roll *= item_odds

		if best_item != null:

			if not loot.has(best_item):

				loot[best_item] = 0

			loot[best_item] += 1

	return loot
		
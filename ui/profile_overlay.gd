class_name ProfileOverlay extends Overlay


@export var inventory_grid: InventoryGrid






func _ready() -> void:

	super()

	Events.subscribe(PlayerInitializedEvent, _on_player_initialized)

	Events.subscribe(PlayerResetEvent, _on_player_reset)









func _on_player_initialized(_event: Event) -> void:

	inventory_grid.load_inventory(Game.player.inventory)



func _on_player_reset(_event: Event) -> void:

	inventory_grid.clear()
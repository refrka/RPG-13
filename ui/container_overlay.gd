class_name ContainerOverlay extends Overlay



@export var inventory_grid: InventoryGrid


var container: Entity



func set_current_container(_container: Entity) -> void:

	container = _container

	if _container != null:

		inventory_grid.load_inventory(container.inventory)

		global_position = container.global_position

	else:

		inventory_grid.clear()




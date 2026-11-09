class_name Player extends Character



@export var interaction_sensor: InteractionSensor


var current_interactable: Entity

var current_interactable_component: InteractableComponent


func initialize() -> void:

	super()

	Events.fire(PlayerInitializedEvent)




func try_interaction() -> void:

	if interaction_sensor.interactable_entities.is_empty():

		return

	if is_interacting():

		current_interactable_component.try_end()

	else:

		interaction_sensor.interactable_entities.sort_custom(_sort_nearest_interactable)

		var nearest = interaction_sensor.interactable_entities.front()

		start_interaction(nearest)




func start_interaction(target_entity: Entity) -> void:

	current_interactable = target_entity

	current_interactable_component = target_entity.get_interactable_component()

	current_interactable_component.interaction_ended.connect(_on_interaction_ended, CONNECT_ONE_SHOT)

	current_interactable_component.start()




func end_interaction() -> void:

	current_interactable = null

	current_interactable_component = null




func is_interacting() -> bool:

	return is_instance_valid(current_interactable) and is_instance_valid(current_interactable_component)




func get_component(component_script: Script) -> Component:
	
	if component_script == MovementComponent:

		component_script = PlayerMovementComponent

	return super(component_script)









func _sort_nearest_interactable(entity_a: Entity, entity_b: Entity) -> bool:

	var distance_a = global_position.distance_squared_to(entity_a.global_position)

	var distance_b = global_position.distance_squared_to(entity_b.global_position)

	return distance_a < distance_b








func _on_interaction_ended() -> void:

	end_interaction()





func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("interact") and Inputs.is_action_allowed("interact"):

		try_interaction()





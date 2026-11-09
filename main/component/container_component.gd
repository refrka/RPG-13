class_name ContainerComponent extends InteractableComponent



var open:= false



func start() -> void:

	var container_overlay = UI.get_overlay(ContainerOverlay)

	UI.add_overlay_to_stack(container_overlay)

	var profile_overlay = UI.get_overlay(ProfileOverlay)

	UI.add_overlay_to_stack(profile_overlay)
	
	container_overlay.set_current_container(entity)

	open = true

	Inputs.disable_action("profile")




func try_end() -> void:

	var container_overlay = UI.get_overlay(ContainerOverlay)

	UI.remove_overlay_from_stack(container_overlay)

	var profile_overlay = UI.get_overlay(ProfileOverlay)

	UI.remove_overlay_from_stack(profile_overlay)

	container_overlay.set_current_container(null)

	open = false

	interaction_ended.emit()

	Inputs.enable_action("profile")









func _process(delta: float) -> void:

	if not active or open:

		return

	
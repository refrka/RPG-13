class_name InteractableComponent extends Component


@warning_ignore("unused_signal")

signal interaction_ended


enum InteractableType {

	DURATION,

	OVERLAY,

	STATE,

}


@export var interactable_type: InteractableType



@export var duration:= -1.0

@export var state_count:= -1





func can_interact() -> bool:

	return true





func start() -> void:

	pass




func try_end() -> void:

	pass
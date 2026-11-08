class_name GameMenu extends Overlay



@export var resume_button: Button

@export var load_button: Button

@export var exit_button: Button

@export var quit_button: Button





func _ready() -> void:

	resume_button.pressed.connect(_on_resume_pressed)

	load_button.pressed.connect(_on_load_pressed)

	exit_button.pressed.connect(_on_exit_pressed)

	quit_button.pressed.connect(_on_quit_pressed)




func activate() -> void:
	
	super()

	Inputs.disable_action("profile")



func deactivate() -> void:

	super()
	
	Inputs.enable_action("profile")




func _on_resume_pressed() -> void:

	UI.remove_overlay_from_stack(self)



func _on_load_pressed() -> void:

	Game.load_last()



func _on_exit_pressed() -> void:

	UI.remove_overlay_from_stack(self)

	Game.exit()



func _on_quit_pressed() -> void:

	Game.quit()
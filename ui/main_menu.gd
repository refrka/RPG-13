class_name MainMenu extends MarginContainer


@export var start_button: Button

@export var reset_button: Button

@export var quit_button: Button



func _ready() -> void:

	Scenes.main_menu = self

	start_button.pressed.connect(_on_start_pressed)

	reset_button.pressed.connect(_on_reset_pressed)

	quit_button.pressed.connect(_on_quit_pressed)






func _on_start_pressed() -> void:

	Game.load_last()



func _on_reset_pressed() -> void:

	Game.reset()



func _on_quit_pressed() -> void:

	Game.quit()
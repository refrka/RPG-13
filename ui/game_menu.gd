class_name GameMenu extends MarginContainer



@export var load_button: Button

@export var exit_button: Button

@export var quit_button: Button





func _ready() -> void:

	load_button.pressed.connect(_on_load_pressed)

	exit_button.pressed.connect(_on_exit_pressed)

	quit_button.pressed.connect(_on_quit_pressed)












func _on_load_pressed() -> void:

	Game.load_last()


func _on_exit_pressed() -> void:

	Game.exit()


func _on_quit_pressed() -> void:

	Game.quit()
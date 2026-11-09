class_name Root extends Node


@export var input_configs: Array[InputConfig]

@export var fade_out_command_set: CommandSet

@export var fade_in_command_set: CommandSet


func _ready() -> void:

	Inputs.input_configs = input_configs.duplicate()

	Game.set_game_state(Game.GameState.MAIN_MENU)

	Events.fire(GameReadyEvent)


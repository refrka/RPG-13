extends Node


@export var input_configs: Array[InputConfig]


func _ready() -> void:

	Inputs.input_configs = input_configs.duplicate()

	Game.set_game_state(Game.GameState.MAIN_MENU)

	Events.fire(GameReadyEvent)


class_name GameStateCondition extends Condition


@export var game_state: Game.GameState




func evaluate(_data:= {}) -> bool:

	super(_data)

	if data.has("game_state"):

		game_state = data.game_state

	return Game.game_state == game_state
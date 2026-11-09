class_name AttachCameraToPlayerCommand extends Command






func execute(_data:= {}) -> Result:

	super(_data)

	Game.camera.set_parent(Game.player)

	Game.camera.set_follow(true)

	return Result.SUCCESS




static func run(_data:= {}) -> Command:

	var command = AttachCameraToPlayerCommand.new()

	command.execute(_data)

	return command
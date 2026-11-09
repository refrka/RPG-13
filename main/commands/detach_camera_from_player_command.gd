class_name DetachCameraFromPlayerCommand extends Command





func execute(_data:= {}) -> Result:

	super(_data)

	Game.camera.set_parent(Scenes.root)

	Game.camera.set_follow(false)

	return Result.SUCCESS





static func run(_data:= {}) -> Command:

	var command = DetachCameraFromPlayerCommand.new()

	command.execute(_data)

	return command
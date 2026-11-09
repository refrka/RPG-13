class_name RunCutsceneCommand extends Command



@export var cutscene: Cutscene




func execute(_data:= {}) -> Result:

	super(_data)

	Scenes.cutscene_ended.connect(_on_cutscene_ended, CONNECT_ONE_SHOT)

	Scenes.run_cutscene(cutscene)

	return Result.PENDING




func _on_cutscene_ended() -> void:

	command_executed.emit(Result.SUCCESS)
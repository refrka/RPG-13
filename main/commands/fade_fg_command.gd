class_name FadeFGCommand extends Command


@export var color: Color

@export var fade_out:= true

@export var rate:= 1.0


var fade_script: NodeScript


func execute(_data:= {}) -> Result:

	super(_data)

	if data.has("rate"):

		rate = data.rate

	if data.has("fade_out"):

		fade_out = data.fade_out

	UI.fg_rect.show()

	UI.fg_rect.color = color

	UI.fg_rect.color.a = 0.0 if fade_out else 1.0

	fade_script = NodeScript.new()

	fade_script.add_process_callback(update_fade)

	UI.fg_rect.add_child(fade_script)

	return Result.PENDING




func cancel() -> void:

	if fade_out:

		UI.fg_rect.color.a = 1.0

	else:

		UI.fg_rect.color.a = 0.0

		UI.fg_rect.hide()




func update_fade(delta: float, _parent: Node) -> void:

	if fade_out:

		if rate < 0.0:

			UI.fg_rect.color.a = 1.0

		else:

			UI.fg_rect.color.a += (delta * rate)

		if UI.fg_rect.color.a >= 1.0:

			end_fade()

	else:

		if rate < 0.0:

			UI.fg_rect.color.a = 0.0

		else:

			UI.fg_rect.color.a -= (delta * rate)

		if UI.fg_rect.color.a <= 0.0:

			UI.fg_rect.hide()

			end_fade()




func end_fade() -> void:

	if is_instance_valid(fade_script):

		fade_script.queue_free()

	command_executed.emit(Result.SUCCESS)





static func run(_data:= {}) -> Command:

	var command = FadeFGCommand.new()

	command.result = command.execute(_data)

	return command
class_name PrintCommand extends Command


@export_multiline var text: String


func execute(_data:= {}) -> Result:

	super(_data)

	if data.has("text"):

		text = data.text

	print(text)

	return Result.SUCCESS
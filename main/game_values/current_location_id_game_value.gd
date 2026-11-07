class_name CurrentLocationIdGameValue extends GameValue





func get_value() -> Variant:

	if not Scenes.current_location:

		return "null/null_1"

	return Scenes.current_location.location_id
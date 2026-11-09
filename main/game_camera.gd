class_name GameCamera extends Camera2D





var follow:= true

var parent: Node




func _ready() -> void:

	set_follow(false)

	set_parent(Scenes.root)




func set_parent(_parent: Node) -> void:

	if get_parent() == _parent:

		return

	parent = _parent

	reparent(parent)




func set_follow(state: bool) -> void:

	follow = state

	if not follow:

		global_position = Vector2.ZERO




func _process(_delta: float) -> void:

	if parent is Node2D and follow:

		global_position = parent.global_position

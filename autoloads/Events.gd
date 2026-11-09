extends Node




var subscriptions: Dictionary[Script, Array]



func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS
	



func subscribe(event_script: Script, callback: Callable) -> void:

	if not subscriptions.has(event_script):

		subscriptions[event_script] = []

	if not subscriptions[event_script].has(callback):

		subscriptions[event_script].append(callback)





func unsubscribe(event_script: Script, callback: Callable) -> void:

	if subscriptions.has(event_script):

		if subscriptions[event_script].has(callback):

			subscriptions[event_script].erase(callback)

		if subscriptions[event_script].is_empty():

			subscriptions.erase(event_script)





func fire(event_script: Script, data:= {}) -> void:

	var event = event_script.new()

	event.data = data

	event.fire()

	if subscriptions.has(event_script):

		for callback in subscriptions[event_script]:

			if callback.is_valid():

				callback.call(event)
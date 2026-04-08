class_name StateProvider extends Provider

func _init(script_factory: Callable = Callable.create(self, "default_script_factory")) -> void:

	var value_factory = func(script: Script) -> StateMachine:
		return script.new()

	_value_container = LazyContainer.new(value_factory, script_factory)

class_name StateListener extends Consumer

func _init(script_factory: Callable = Callable.create(self, "default_script_factory")) -> void:
	
	var value_factory = func(script: Script) -> StateMachine:
		var machine: StateMachine = Provider.of_type(script, self)
		machine.state_changed.connect(self._on_state_changed)
		return machine
		
	_value_container = LazyContainer.new(value_factory, script_factory)

func default_script_factory() -> Script:
	return StateMachine

func _on_state_changed(_state: State) -> void:
	pass

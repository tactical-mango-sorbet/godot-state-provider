class_name ProcessorStateMachine extends StateMachine

func _physics_process(delta: float, node: StateProcessor) -> void:
	get_state()._physics_process(delta, node)
	node._state_physics_process(delta, get_state())

func _process(delta: float, node: StateProcessor) -> void:
	get_state()._process(delta, node)
	node._state_process(delta, get_state())

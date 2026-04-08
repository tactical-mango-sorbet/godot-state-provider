class_name ProcessorStateMachine extends StateMachine

func _physics_process(delta: float, processor) -> void:
	get_state()._physics_process(delta, processor)
	processor._state_physics_process(delta, get_state())

func _process(delta: float, processor) -> void:
	get_state()._process(delta, processor)
	processor._state_process(delta, get_state())

class_name StateProcessor extends Consumer

func get_value() -> ProcessorStateMachine:
	return super.get_value()

func _physics_process(delta: float) -> void:
	get_value()._physics_process(delta, self)

func _process(delta: float) -> void:
	get_value()._process(delta, self)

func _state_physics_process(_delta: float, _state: ProcessorState) -> void:
	pass

func _state_process(_delta: float, _state: ProcessorState) -> void:
	pass

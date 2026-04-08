class_name PlayerStateMachine extends ProcessorStateMachine

func _init() -> void:
	set_state(PlayerState.Idle.new())

func get_state_type() -> Script:
	return PlayerState

func _physics_process(delta: float, processor: PlayerProcessor) -> void:
	if Input.get_vector("move_left", "move_right", "move_up", "move_down") == Vector2.ZERO:
		set_state(PlayerState.Idle.new())
	else:
		set_state(PlayerState.Move.new())
	super._physics_process(delta, processor)

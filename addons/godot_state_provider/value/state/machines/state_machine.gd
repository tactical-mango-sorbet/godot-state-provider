class_name StateMachine extends Value

signal state_changed(state: State)

var state: State

func _init(initialState: State = null) -> void:
	if initialState == null:
		push_warning(identifier + " should be initialised with a state however it was not")
	state = initialState

func get_state_type() -> Script:
	return State

func get_state() -> State:
	return state

func set_state(value: State) -> void:
	if not _accepts_state(value):
		return
	if state != null:
		if value.is_type(state.type):
			return
		await state._on_exit()
	state = value
	await state._on_enter()
	state_changed.emit(state)

func init_new_state(script: Script) -> void:
	await set_state(script.new())

func _accepts_state(val: State) -> bool:
	return val != null and val.inherits(get_state_type())

class_name PlayerProcessor extends StateProcessor

@export var player: CharacterBody2D

const SPEED = 200.0

func _init() -> void:
	var machine: StateMachine = PlayerStateMachine.new()
	machine.state_changed.connect(self._on_state_changed)
	_value_container = ValueContainer.new(machine)

func get_value() -> PlayerStateMachine:
	return super.get_value()

func _on_state_changed(value: State) -> void:
	print("Printing the change of state: " + value._to_string() + " for the purpose of the example.")

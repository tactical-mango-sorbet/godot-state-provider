class_name BaseProvider extends Node

@export var value_script: Script

func default_script_factory() -> Script:
	return value_script

var _value_container: ValueContainer

func _init() -> void:
	_value_container = ValueContainer.new(Value.new())

func get_value() -> Value:
	return _value_container.get_value()

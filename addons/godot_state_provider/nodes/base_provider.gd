class_name BaseProvider extends Node

var _value_container: ValueContainer

func _init() -> void:
	_value_container = ValueContainer.new(Value.new())

func get_value() -> Value:
	return _value_container.get_value()
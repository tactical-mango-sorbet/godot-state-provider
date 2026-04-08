class_name ValueContainer extends RefCounted

var _value: Value

func _init(value: Value) -> void:
	value = value

func get_value() -> Value:
	return _value

func get_type() -> Script:
	return _value.type

func set_value(value) -> void:
	_value = value

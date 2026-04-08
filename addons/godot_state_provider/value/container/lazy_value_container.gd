class_name LazyContainer extends ValueContainer

var _type: Script
var _value_factory: Callable
var _script_factory: Callable
var _initialized: bool = false

func _init(value_factory: Callable, script_factory: Callable) -> void:
	_value_factory = value_factory
	_script_factory = script_factory

func _accepts(val: Value) -> bool:
	return val != null and val.inherits(get_type())
	
func get_value() -> Value:
	if not _initialized:
		_initialize()
	return _value

func get_type() -> Script:
	if _type == null:
		_type = _script_factory.call()
	return _type

func set_value(val: Value) -> void:
	if not _accepts(val):
		push_warning(str(self) + ": cannot set value — type '" + val.get_script().get_global_name() + "' does not inherit '" + get_type().get_global_name() + "'")
		return
	_value = val

func _initialize() -> void:
	if _initialized:
		return
	var val: Value = _value_factory.call(get_type())
	if not _accepts(val):
		push_warning(str(self) + ": created value of type '" + val.get_script().get_global_name() + "' does not inherit '" + get_type().get_global_name() + "'")
		return
	_initialized = true
	_value = val

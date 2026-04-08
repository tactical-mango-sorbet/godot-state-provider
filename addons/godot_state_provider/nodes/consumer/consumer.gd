class_name Consumer extends BaseProvider

func _init(script_factory: Callable = Callable.create(self, "default_script_factory")) -> void:
	
	var value_factory = func(script: Script) -> Value:
		return Provider.of_type(script, self)
	
	_value_container = LazyContainer.new(value_factory, script_factory)

func default_script_factory() -> Script:
	return Value

class_name Provider extends BaseProvider

@export var value_script: Script

static func value_id_of(_type: Script) -> StringName:
	return _type.get_identifier_of(_type)

static func of_type(_type: Script, node: Node) -> Value:
	return of_id(value_id_of(_type), node)

static func of_id(provider_id: StringName, node: Node) -> Value:
	for candidate in node.get_tree().get_nodes_in_group(provider_id):
		if candidate is Provider and candidate.is_ancestor_of(node):
			return candidate.get_value()
	push_warning("Provider: could not resolve machine for " + provider_id)
	return null

func _init(script_factory: Callable = Callable.create(self, "default_script_factory")) -> void:

	var value_factory = func(script: Script) -> Value:
		return script.new()

	_value_container = LazyContainer.new(value_factory, script_factory)

func default_script_factory() -> Script:
	return value_script

func _enter_tree() -> void:
	add_to_group(value_id_of(_value_container.get_type()))

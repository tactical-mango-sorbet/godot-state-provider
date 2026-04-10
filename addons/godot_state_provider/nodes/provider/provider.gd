class_name Provider extends BaseProvider

const IDENTIFIER_SUFFIX: StringName = "Provider"

@export var value_script: Script

static func provider_id_of(_type: Script) -> StringName:
	return _type.get_identifier_of(_type) + IDENTIFIER_SUFFIX

static func of_type(_type: Script, node: Node) -> Value:
	return of_id(provider_id_of(_type), node)

static func of_id(provider_id: StringName, node: Node) -> Value:
	return node.find_parent(provider_id).get_value()

func _init(script_factory: Callable = Callable.create(self, "default_script_factory")) -> void:

	var value_factory = func(script: Script) -> Value:
		return script.new()

	_value_container = LazyContainer.new(value_factory, script_factory)

func default_script_factory() -> Script:
	return value_script

func _enter_tree() -> void:
	name = provider_id_of(_value_container.get_type())

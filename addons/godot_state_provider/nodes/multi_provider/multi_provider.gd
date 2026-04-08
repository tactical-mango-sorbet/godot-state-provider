class_name MultiProvider extends BaseProvider

@export var scripts: Array[Script]

func get_provider_scripts() -> Array[Script]:
	return scripts.duplicate()

func map_script_to_provider(script: Script) -> Provider:
	return Provider.new(func() -> Script: return script)

func _enter_tree() -> void:
	var _original_children: Array[Node] = get_children()

	for child in _original_children:
		remove_child(child)

	var scripts: Array[Script] = get_provider_scripts()
	var _injected_providers: Array[Provider]
	_injected_providers.assign(scripts.map(map_script_to_provider))

	var deepest_provider: Node = self
	for provider in _injected_providers:
		deepest_provider.add_child(provider)
		deepest_provider = provider

	for child in _original_children:
		deepest_provider.add_child(child)

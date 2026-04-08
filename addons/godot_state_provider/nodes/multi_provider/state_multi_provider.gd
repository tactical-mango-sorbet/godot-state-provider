class_name StateMultiProvider extends MultiProvider

func map_script_to_provider(script: Script) -> StateProvider:
	return StateProvider.new(func() -> Script: return script)

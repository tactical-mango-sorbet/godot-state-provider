class_name Value extends RefCounted

static func get_identifier_of(_type: Script) -> StringName:
	return _type.get_global_name()

var identifier: StringName:
	get:
		return get_identifier_of(type)

var type: Script:
	get:
		return get_script()

func is_type(_type: Script) -> bool:
	return _type.instance_has(self)

func inherits(_type: Script) -> bool:
	var instance_script = type
	while instance_script != null:
		if instance_script == _type:
			return true
		instance_script = instance_script.get_base_script()
	return false

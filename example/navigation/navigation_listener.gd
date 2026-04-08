extends StateListener

@export var menu_packed_scene: PackedScene
@export var game_packed_scene: PackedScene

func _init() -> void:
	super._init(func() -> Script: return NavigationStateMachine)

func get_value() -> NavigationStateMachine:
	return super.get_value()

func _ready() -> void:
	get_value().navigate_to_menu()

func _on_state_changed(state) -> void:
	if state.is_type(NavigationState.Menu):
		state.transition_from(self, menu_packed_scene)
	elif state.is_type(NavigationState.Game):
		state.transition_from(self, game_packed_scene)

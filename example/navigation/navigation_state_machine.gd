class_name NavigationStateMachine extends StateMachine

func get_state() -> NavigationState:
	return state
	
func get_state_type() -> Script:
	return NavigationState

func navigate_to_menu() -> void:
	set_state(NavigationState.Menu.new())

func navigate_to_game() -> void:
	set_state(NavigationState.Game.new())

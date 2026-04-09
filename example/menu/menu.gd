extends Node

func _ready() -> void:
	$Button.pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	Provider.of_type(NavigationStateMachine, self).navigate_to_game()

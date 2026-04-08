extends Node

func _ready() -> void:
	$Button.pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	get_parent().get_value().navigate_to_menu()

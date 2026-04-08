class_name NavigationState extends State

# Default transition
func transition_from(parent: Node, packed_scene: PackedScene) -> void:
	parent.call_deferred("add_child", packed_scene.instantiate())
	for child in parent.get_children():
		child.queue_free()

class Menu extends NavigationState:
	pass
	
class Game extends NavigationState:
	# Custom transition for game state
	func transition_from(parent: Node, packed_scene: PackedScene) -> void:
		parent.call_deferred("add_child", packed_scene.instantiate())
		for child in parent.get_children():
			child.queue_free()

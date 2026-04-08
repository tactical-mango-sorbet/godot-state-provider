class_name PlayerState extends ProcessorState

class Idle extends PlayerState:
	func _to_string() -> String:
		return "Idle"
		
class Move extends PlayerState:
	func _to_string() -> String:
		return "Move"

	func _physics_process(_delta: float, _processor: PlayerProcessor) -> void:
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		_processor.player.velocity = direction * _processor.SPEED
		_processor.player.move_and_slide()

extends Control
var paused = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed(&"PauseRemap"):
		if !paused:
			visible = true
			paused = true
			get_tree().paused = true
		else:
			visible = false
			paused = false
			get_tree().paused = false

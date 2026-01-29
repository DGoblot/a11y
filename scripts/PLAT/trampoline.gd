extends Sprite2D

var trampoline_mode = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	get_child(0).monitorable = false
	trampoline_mode = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed(&"SwitchTrampoline"):
		if trampoline_mode:
			visible = false
			get_child(0).monitorable = false
			trampoline_mode = false
		else:
			visible = true
			get_child(0).monitorable = true
			trampoline_mode = true

extends Sprite2D

var pos_high
var pos_middle
var pos_low
var dir = "down"
@onready var down_arrow = $DownArrow
@onready var up_arrow = $UpArrow
var screen_size

var one_button_mode = false

signal hit

func _ready() -> void:
	up_arrow.self_modulate.a = 0
	down_arrow.self_modulate.a = 0
	screen_size = get_viewport_rect().size
	pos_high = Vector2(0.1*screen_size.x,0.2*screen_size.y)
	pos_middle = Vector2(0.1*screen_size.x,0.5*screen_size.y)
	pos_low = Vector2(0.1*screen_size.x,0.8*screen_size.y)
	position = pos_middle

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_just_pressed(&"Down") and !one_button_mode:
		if (position == pos_high):
			position = pos_middle
			dir = "down"
		else :if (position == pos_middle):
			position = pos_low
			dir = "up"
		
	if Input.is_action_just_pressed(&"Up") and !one_button_mode:
		if (position == pos_low): 
			position = pos_middle
			dir = "up"
		else :if (position == pos_middle): 
			position = pos_high
			dir = "down"
		
	if Input.is_action_just_pressed(&"SwitchOneButtonMode"):
		if one_button_mode:
			one_button_mode = false
			up_arrow.self_modulate.a = 0
			down_arrow.self_modulate.a = 0
		else:
			one_button_mode = true
			if (dir == "down"): 
					down_arrow.self_modulate.a = 1
					up_arrow.self_modulate.a = 0.1
			else :
					down_arrow.self_modulate.a = 0.1
					up_arrow.self_modulate.a = 1
	
	if Input.is_action_just_pressed(&"OneButtonMode") and one_button_mode:
		match position:
			pos_high: 
				position = pos_middle
				dir = "down"
				up_arrow.self_modulate.a = 0.1
			pos_low:
				position = pos_middle
				dir = "up"
				down_arrow.self_modulate.a = 0.1
			pos_middle:
				if (dir == "down"): 
					position = pos_low
					up_arrow.self_modulate.a = 1
					down_arrow.self_modulate.a = 0.1
				else :
					position = pos_high
					up_arrow.self_modulate.a = 0.1
					down_arrow.self_modulate.a = 1
		
	if Input.is_action_just_released(&"Switch"):
		get_tree().change_scene_to_file("res://scenes/STORY/story3.tscn")


func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area.name == "ObstacleArea"):
		hit.emit()
		area.get_parent().queue_free()
	if (area.name == "FinishArea"):
		get_tree().change_scene_to_file("res://scenes/STORY/story3.tscn")

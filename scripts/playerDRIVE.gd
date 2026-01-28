extends Sprite2D

@export var speed = 400.0
var pos_high
var pos_middle
var pos_low
var screen_size

signal hit

func _ready() -> void:
	screen_size = get_viewport_rect().size
	pos_high = Vector2(0.1*screen_size.x,0.2*screen_size.y)
	pos_middle = Vector2(0.1*screen_size.x,0.5*screen_size.y)
	pos_low = Vector2(0.1*screen_size.x,0.8*screen_size.y)
	position = pos_middle

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_just_pressed(&"Down"):
		if (position == pos_high): position = pos_middle
		else :if (position == pos_middle): position = pos_low
		
	if Input.is_action_just_pressed(&"Up"):
		if (position == pos_low): position = pos_middle
		else :if (position == pos_middle): position = pos_high
		
	if Input.is_action_just_released(&"Switch"):
		get_tree().change_scene_to_file("res://scenes/SHMUP.tscn")

	velocity = velocity.normalized() * speed
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func _on_area_2d_area_entered(area: Area2D) -> void:
	hit.emit()
	area.get_parent().queue_free()

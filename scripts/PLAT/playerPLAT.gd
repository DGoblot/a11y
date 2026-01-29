extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
var timer = 0


func _physics_process(delta: float) -> void:
	timer += delta
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed(&"Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction := Input.get_axis(&"Left", &"Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if Input.is_action_just_released(&"Switch") and timer > 0.1:
		get_tree().change_scene_to_file("res://scenes/DRIVE/DRIVE.tscn")

	move_and_slide()


func _on_death_zone_body_entered(body: Node2D) -> void:
	print_debug("dead")
	get_tree().change_scene_to_file("res://scenes/PLAT/PLAT.tscn")


func _on_finish_area_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://scenes/DRIVE/DRIVE.tscn")

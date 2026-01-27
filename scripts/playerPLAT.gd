extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed(&"Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction := Input.get_axis(&"Left", &"Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if Input.is_action_just_pressed(&"Switch"):
		get_tree().change_scene_to_file("res://scenes/DRIVE.tscn")

	move_and_slide()


func _on_death_zone_area_entered(area: Area2D) -> void:
	print_debug("dead")
	get_tree().change_scene_to_file("res://scenes/PLAT.tscn")

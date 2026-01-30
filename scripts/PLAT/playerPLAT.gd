extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
var timer = 0


@onready var sound_jump = $"../Jump"
@onready var sound_tramp = $"../Trampoline"
@onready var sound_death = $"../Death"

func _physics_process(delta: float) -> void:
	timer += delta
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed(&"Jump") and is_on_floor():
		sound_jump.play()
		_jump()
	var direction := Input.get_axis(&"Left", &"Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if Input.is_action_just_released(&"Switch") and timer > 0.1:
		get_tree().change_scene_to_file("res://scenes/STORY/story6.tscn")

	move_and_slide()
	
func _jump() -> void:
	velocity.y = JUMP_VELOCITY


func _on_death_zone_body_entered(body: Node2D) -> void:
	if body.name == "PlayerPLAT":
		sound_death.play()
		visible = false
		await get_tree().create_timer(1.0).timeout
		
		get_tree().change_scene_to_file("res://scenes/PLAT/PLAT.tscn")


func _on_finish_area_body_entered(body: Node2D) -> void:
	if body.name == "PlayerPLAT":
		get_tree().change_scene_to_file("res://scenes/STORY/story6.tscn")


func _on_trampoline_detector_area_entered(area: Area2D) -> void:
	if area.name == "TrampArea":
		sound_tramp.play()
		_jump()

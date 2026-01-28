extends Sprite2D

@onready var bullets = $"../Bullets"
@export var bullet_scene: PackedScene
@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

var hp = 3


func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed(&"Down"):
		velocity.y += 1
	if Input.is_action_pressed(&"Up"):
		velocity.y -= 1
	if Input.is_action_pressed(&"Right"):
		velocity.x += 1
	if Input.is_action_pressed(&"Left"):
		velocity.x -= 1
	if Input.is_action_just_pressed(&"Shoot"):
		var bullet = bullet_scene.instantiate()
		bullet.position = position
		bullets.add_child(bullet)
	if Input.is_action_just_released(&"Switch"):
		get_tree().change_scene_to_file("res://scenes/PLAT/PLAT.tscn")

	velocity = velocity.normalized() * speed

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if (hp <= 0):
		get_tree().change_scene_to_file("res://scenes/SHMUP/SHMUP.tscn")


func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area.name == "EnnemieArea"):
		print_debug("aie")

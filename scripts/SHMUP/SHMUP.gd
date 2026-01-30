extends Node2D

@onready var parallax = $Camera2D/BackgroundSHMUP/Parallax2D
@onready var ennemies_node = $Ennemies
@export var ennemie_scene: PackedScene
@onready var finish_node = $Finish
@export var finish_scene: PackedScene
@onready var bullets_node = $Bullets
@export var ennemie_time = 1.5
var ennemie_timer = 0
@export var finish_time = 10
var finish_timer = 0
var done = false

var speed = 500.0
var bullet_speed = 1000
var bullet_time = false

var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size
	parallax.autoscroll.x = -speed

func _process(delta: float) -> void:
	if Input.is_action_just_pressed(&"BulletTime") and !bullet_time:
		bullet_time = true
		for ennemie in ennemies_node.get_children():
			ennemie.speed = 0
			ennemie.bullet_time = true
		for finish in finish_node.get_children():
			finish.speed = 0
		for bullet in bullets_node.get_children():
			bullet.speed = 0
		parallax.autoscroll.x = 0
			
	if Input.is_action_just_pressed(&"Shoot") and bullet_time:
		bullet_time = false
		for ennemie in ennemies_node.get_children():
			ennemie.speed = speed
			ennemie.bullet_time = false
		for finish in finish_node.get_children():
			finish.speed = speed
		for bullet in bullets_node.get_children():
			bullet.speed = bullet_speed
		parallax.autoscroll.x = -speed

	

	if !bullet_time:
		print_debug(finish_timer)
		finish_timer += delta
		if (finish_timer >= finish_time and !done):
			var finish = finish_scene.instantiate()
			finish.speed = -parallax.autoscroll.x
			finish.position = Vector2(screen_size.x * 1.5 ,screen_size.y * 0.5)
			finish_node.add_child(finish)
			done = true
		ennemie_timer += delta
		if (ennemie_timer > ennemie_time and !done): 
			spawn_ennemie(randi_range(-screen_size.y * 0.4, screen_size.y * 0.4))
			ennemie_timer = 0

func spawn_ennemie(y: float) -> void:
	var ennemie = ennemie_scene.instantiate()
	ennemie.position = Vector2(screen_size.x * 1.5 ,screen_size.y * 0.5 + y)
	ennemies_node.add_child(ennemie)

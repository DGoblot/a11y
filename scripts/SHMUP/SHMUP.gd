extends Node2D

@onready var parallax = $Camera2D/BackgroundSHMUP/Parallax2D
@onready var ennemies = $Ennemies
@export var ennemie_scene: PackedScene
@onready var finish_node = $Finish
@export var finish_scene: PackedScene
@export var ennemie_time = 1.5
var ennemie_timer = 0
@export var finish_time = 10
var finish_timer = 0
var done = false

var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
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
	ennemies.add_child(ennemie)

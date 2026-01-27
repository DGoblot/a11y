extends Node2D

@onready var obstacles = $Obstacles
@export var obstacle_scene: PackedScene
var obstacle_timer = 2
var timer = 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	timer += delta
	if (timer > obstacle_timer): 
		spawn_obstacle(0,0)
		timer = 0

func spawn_obstacle(x: float, y: float) -> void:
	var obstacle = obstacle_scene.instantiate()
	
	#obstacle.position = Vector2(x,y)
	obstacle.position = Vector2(1074,306)

	obstacles.add_child(obstacle)

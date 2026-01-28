extends Node2D

@onready var parallax = $Camera2D/BackgroundDRIVE/Parallax2D
@onready var obstacles = $Obstacles
@export var obstacle_scene: PackedScene
var obstacle_timer = 1
var spawn_timer = 0

var goal_speed = 800.0
var speed = 0
var lerp_speed = 0.001
var lerp_timer = 0

var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size
	speed = 0.0

func _process(delta: float) -> void:
	lerp_timer += delta
	speed = lerp(speed, goal_speed, lerp_timer * lerp_speed)
	
	for obstacle in obstacles.get_children():
		obstacle.speed = speed
	parallax.autoscroll.x = -speed
	
	spawn_timer += delta * speed
	if (spawn_timer > obstacle_timer): 
		if(randi_range(0,4)):
			var missing_lane = randi_range(0,2)
			match missing_lane:
				0:
					spawn_obstacle(1)
					spawn_obstacle(2)
				1:
					spawn_obstacle(0)
					spawn_obstacle(2)
				2:
					spawn_obstacle(0)
					spawn_obstacle(1)
			
			
		else :
			spawn_obstacle(randi_range(0,2))
		spawn_timer = 0

func spawn_obstacle(lane: int) -> void:
	var obstacle = obstacle_scene.instantiate()
	var y_pos
	match lane:
		0:
			y_pos = screen_size.y * 0.2
		1:
			y_pos = screen_size.y * 0.5
		2:
			y_pos = screen_size.y * 0.8
			
	obstacle.position = Vector2(screen_size.x * 1.5 ,y_pos)
	obstacles.add_child(obstacle)


func _on_player_drive_hit() -> void:
	speed = 0.0
	lerp_timer = 0.0

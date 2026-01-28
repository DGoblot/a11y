extends Node2D

@onready var parallax = $Camera2D/BackgroundDRIVE/Parallax2D
@onready var obstacles_node = $Obstacles
@export var obstacle_scene: PackedScene
@onready var finish_node = $Finish
@export var finish_scene: PackedScene
@export var obstacle_time = 1
var obstacle_timer = 0
@export var finish_time = 4
var finish_timer = 0
var done = false

@export var goal_speed = 800.0
var speed = 0
@export var lerp_speed = 0.001
var lerp_timer = 0

var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size
	speed = 0.0

func _process(delta: float) -> void:
	lerp_timer += delta
	speed = lerp(speed, goal_speed, lerp_timer * lerp_speed)
	
	for obstacle in obstacles_node.get_children():
		obstacle.speed = speed
	for finish in finish_node.get_children():
		finish.speed = speed
	parallax.autoscroll.x = -speed
	
	finish_timer += delta * (speed/1000)
	if (finish_timer >= finish_time and !done):
		var finish = finish_scene.instantiate()
		finish.position = Vector2(screen_size.x * 1.5 ,screen_size.y * 0.5)
		finish_node.add_child(finish)
		done = true
	
	obstacle_timer += delta * (speed/1000)
	if (obstacle_timer > obstacle_time and !done): 
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
		obstacle_timer = 0
		


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
	obstacles_node.add_child(obstacle)


func _on_player_drive_hit() -> void:
	speed = 0.0
	lerp_timer = 0.0

extends Node2D

@onready var ennemies = $Ennemies
@export var ennemie_scene: PackedScene
var ennemie_timer = 1
var timer = 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	timer += delta
	if (timer > ennemie_timer): 
		spawn_ennemie(0,randi_range(-300,300))
		timer = 0

func spawn_ennemie(x: float, y: float) -> void:
	var ennemie = ennemie_scene.instantiate()
	ennemie.position = Vector2(1274,306+y)
	ennemies.add_child(ennemie)

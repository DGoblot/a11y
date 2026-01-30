extends Sprite2D

@onready var parallax = $"../../Camera2D/BackgroundSHMUP/Parallax2D"
@export var bullet_scene: PackedScene
@onready var player = $"../../PlayerSHMUP"
var speed
var screen_size
var hp = 2
var bullet_time = false
@export var shooting_time = 1
var shooting_timer = 0

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	speed = -parallax.autoscroll.x
	var velocity = Vector2.ZERO
	velocity.x = -1
	velocity = velocity.normalized() * speed
	position += velocity * delta
	
	if !bullet_time:
		shooting_timer += delta
		if(shooting_timer >= shooting_time):
			if player.position.x + 100 < position.x:
				var bullet = bullet_scene.instantiate()
				bullet.position = position
				bullet.dir = player.position - position
				bullet.target = "PlayerArea"
				get_tree().get_root().get_node("SHMUP/Bullets").add_child(bullet)
			shooting_timer = 0
	
	if (hp <= 0):
		queue_free()
		
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

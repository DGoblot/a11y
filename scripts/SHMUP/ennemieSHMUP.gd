extends Sprite2D

@onready var parallax = $"../../Camera2D/BackgroundSHMUP/Parallax2D"
var speed
var screen_size
var hp = 2

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	speed = -parallax.autoscroll.x
	var velocity = Vector2.ZERO
	
	velocity.x -= 1
	
	velocity = velocity.normalized() * speed

	position += velocity * delta
	
	if (hp <= 0):
		queue_free()
		
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

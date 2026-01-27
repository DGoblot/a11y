extends Sprite2D

@onready var parallax = $"../../Camera2D/Background/Parallax2D"
var speed
var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	speed = -parallax.autoscroll.x
	var velocity = Vector2.ZERO
	
	velocity.x -= 1
	
	velocity = velocity.normalized() * speed

	position += velocity * delta
	
	if (position.x < 0): 
		pass

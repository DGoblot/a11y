extends Sprite2D

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.


func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed(&"Down"):
		velocity.y += 1
	if Input.is_action_pressed(&"Up"):
		velocity.y -= 1
		
	velocity = velocity.normalized() * speed

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

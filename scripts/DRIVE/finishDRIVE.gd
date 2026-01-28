extends Sprite2D

var speed
var screen_size

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	velocity.x -= 1
	velocity = velocity.normalized() * speed
	position += velocity * delta

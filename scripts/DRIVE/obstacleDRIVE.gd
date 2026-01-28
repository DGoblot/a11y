extends Sprite2D

var speed
var screen_size

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	velocity.x -= 1
	velocity = velocity.normalized() * speed
	position += velocity * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

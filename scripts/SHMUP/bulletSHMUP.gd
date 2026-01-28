extends Sprite2D

var speed = 1000
var dir = 1
var target = "EnnemieArea"

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	velocity.x += dir
	
	velocity = velocity.normalized() * speed

	position += velocity * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.name == target):
		area.get_parent().hp -= 1
		queue_free()
		

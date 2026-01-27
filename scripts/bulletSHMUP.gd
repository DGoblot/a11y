extends Sprite2D

var speed = 1000

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	velocity.x += 1
	
	velocity = velocity.normalized() * speed

	position += velocity * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.name == "EnnemieArea"):
		area.get_parent().hp -= 1
		queue_free()
		

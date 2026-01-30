extends Sprite2D

var speed = 1000
var dir = Vector2(-1,0)
var target = "EnnemieArea"

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	var norm = Vector2(-1,0)
	dir = dir.normalized()
	rotation = norm.angle_to(dir)
	velocity = dir
	
	velocity = velocity.normalized() * speed

	position += velocity * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.name == target):
		area.get_parent().hp -= 1
		queue_free()
		

extends Control

var mode = 1
@onready var text1 = $RichTextLabel1
@onready var text2 = $RichTextLabel2
@onready var text3 =$RichTextLabel3
@onready var rect1 = $RichTextLabel/ColorRect

func _process(delta: float) -> void:
	if Input.is_action_just_pressed(&"GoNext"):
		match name:
			"Story1":
				get_tree().change_scene_to_file("res://scenes/STORY/story2.tscn")
			"Story2":
				get_tree().change_scene_to_file("res://scenes/DRIVE/DRIVE.tscn")
			"Story3":
				get_tree().change_scene_to_file("res://scenes/STORY/story4.tscn")
			"Story4":
				get_tree().change_scene_to_file("res://scenes/SHMUP/SHMUP.tscn")
			"Story5":
				get_tree().change_scene_to_file("res://scenes/PLAT/PLAT.tscn")
			"Story6":
				get_tree().change_scene_to_file("res://scenes/STORY/story1.tscn")
		
		
	if Input.is_action_just_pressed(&"ChangeText"):
		match mode:
			1:
				text1.visible = false
				text2.visible = true
				mode = 2
			2:
				text2.visible = false
				text3.visible = true
				mode = 3
			3:
				text3.visible = false
				text1.visible = true
				mode = 1

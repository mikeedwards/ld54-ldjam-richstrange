extends Node2D

func _process(_delta):
	if Input.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://World/main.tscn")
	

extends Area2D

func _process(_delta):
	if get_overlapping_bodies():
		get_tree().reload_current_scene()

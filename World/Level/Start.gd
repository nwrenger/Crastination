extends Node2D

func _on_Animation_animation_finished(_anim_name):
	get_tree().change_scene_to_file("res://World/Level/Level1.tscn")

func _enter_tree():
	get_node("/root/Save").time = 0
	get_node("/root/Save").dash = false

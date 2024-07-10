extends Node2D

func _ready():
	$AnimationFade.play("main")
	get_node("/root/Save").dash = true
	get_node("/root/Save").level = 11

func _on_Animation_animation_finished(_anim_name):
	get_tree().change_scene_to_file("res://World/Title.tscn")

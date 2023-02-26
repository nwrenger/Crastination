extends Node2D

func _ready():
	$AnimationFade.play("main")
	get_node("/root/Save").level = 0

func _on_Animation_animation_finished(_anim_name):
	get_tree().change_scene("res://World/Title.tscn")

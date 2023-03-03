extends Node2D

func _ready():
	$AnimationFade.play("main")

func _on_Animation_animation_finished(_anim_name):
	get_tree().change_scene_to_file("res://World/Level/Level1.tscn")

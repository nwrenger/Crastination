extends Node2D

export var NextScene: PackedScene

func _ready():
	$AnimationFade.play("main")

func _on_Animation_animation_finished(_anim_name):
	get_tree().change_scene_to(NextScene)

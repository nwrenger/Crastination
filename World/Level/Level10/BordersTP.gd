extends Area2D

export var NextScene: PackedScene

func BordersTP_entered(_body):
	get_tree().change_scene_to(NextScene)

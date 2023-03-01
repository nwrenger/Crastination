extends AnimationPlayer

func _ready():
	play("main")


func animation_finished(_anim_name):
	get_tree().change_scene("res://World/Level/End.tscn")

extends Node2D

export var NextScene: PackedScene
var TotalLevel := 11


func Area_entered(_body):
	$Light.show()
	$AnimationFade.play("FadeOut")
	$Light.energy = 1.8
	$Light.scale = Vector2(1.5,1.5)
	yield($AnimationFade, "animation_finished")
	# warning-ignore:return_value_discarded
	get_tree().change_scene_to(NextScene)

func _enter_tree():
	#todo proof for less work
	for i in TotalLevel:
		if get_parent().name == "Level" + str(i):
			get_node("/root/Save").level = i

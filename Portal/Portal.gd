extends Node2D

export var NextScene: PackedScene


func _process(_delta):
	if $Area.get_overlapping_bodies():
		$Light.show()
		$AnimationFade.play("FadeOut")
		$Light.energy = 1.8
		$Light.scale = Vector2(1.5,1.5)
		yield($AnimationFade, "animation_finished")
		# warning-ignore:return_value_discarded
		get_tree().change_scene_to(NextScene)

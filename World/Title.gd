extends CanvasLayer

export var NextScene: PackedScene


func _ready():
	$AnimationFade.play("FadeIn")

func toggle():
	$AnimationFade.play("FadeOut")

	yield($AnimationFade, "animation_finished")
	# warning-ignore:return_value_discarded
	get_tree().change_scene_to(NextScene)

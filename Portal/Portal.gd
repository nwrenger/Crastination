extends Node2D

export var NextScene: PackedScene


func _process(_delta):
    if $Area.get_overlapping_bodies():
        $Light.show()
        $AnimationFade.play("FadeOut")

        yield($AnimationFade, "animation_finished")
        # warning-ignore:return_value_discarded
        get_tree().change_scene_to(NextScene)

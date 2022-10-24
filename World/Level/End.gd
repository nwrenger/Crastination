extends Node2D

func _ready():
    $AnimationFade.play("FadeIn")

func _on_Animation_animation_finished(_anim_name):
    $AnimationFade.play("FadeOut")
    $CanvasLayer/Text.bbcode_text = "The END?"

    yield($AnimationFade, "animation_finished")
    # warning-ignore:return_value_discarded
    get_tree().change_scene("res://World/Title.tscn")

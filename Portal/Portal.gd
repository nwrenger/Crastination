extends Node2D

@export var NextScene: PackedScene
var TotalLevel := 21


func Area_entered(_body):
	$AnimationFade.play("FadeOut")
	$Light.energy = 3
	$Light.scale = Vector2(1.5,1.5)
	await $AnimationFade.animation_finished
	get_tree().change_scene_to_packed(NextScene)

func _ready():
	#todo proof for less work
	for i in TotalLevel:
		if get_parent().name == "Level" + str(i):
			get_node("/root/Save").level = i

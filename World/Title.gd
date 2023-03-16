extends Node

@export var Start: PackedScene
@export var Level1: PackedScene
@export var Level2: PackedScene
@export var Level3: PackedScene
@export var Level4: PackedScene
@export var Level5: PackedScene
@export var Level6: PackedScene
@export var Level7: PackedScene
@export var Level8: PackedScene
@export var Level9: PackedScene
@export var Level10: PackedScene
@export var Level11: PackedScene

func _ready():
	Engine.max_fps = 60
	$Canvas/AnimationFade.play("FadeIn")
	if get_node("/root/Save").level > 0:
		$Canvas/CurrentLevel.show()
		$Canvas/CurrentLevel.text = "Current Level: " +  str(get_node("/root/Save").level)
	if get_node("/root/Save").level >= 11:
		$Background.hide()
		$BackgroundBugged.show()
	else:
		$Background.show()
		$BackgroundBugged.hide()
func toggle():
	$Canvas/AnimationFade.play("FadeOut")

	await $Canvas/AnimationFade.animation_finished
	# warning-ignore:return_value_discarded

		#todo for loop
		#for first time playing sceneTitle.tscn
	if 0 == get_node("/root/Save").level:
		get_tree().change_scene_to_packed(Start)
	elif 1 == get_node("/root/Save").level:
		get_tree().change_scene_to_packed(Level1)
	elif 2 == get_node("/root/Save").level:
		get_tree().change_scene_to_packed(Level2)
	elif 3 == get_node("/root/Save").level:
		get_tree().change_scene_to_packed(Level3)
	elif 4 == get_node("/root/Save").level:
		get_tree().change_scene_to_packed(Level4)
	elif 5 == get_node("/root/Save").level:
		get_tree().change_scene_to_packed(Level5)
	elif 6 == get_node("/root/Save").level:
		get_tree().change_scene_to_packed(Level6)
	elif 7 == get_node("/root/Save").level:
		get_tree().change_scene_to_packed(Level7)
	elif 8 == get_node("/root/Save").level:
		get_tree().change_scene_to_packed(Level8)
	elif 9 == get_node("/root/Save").level:
		get_tree().change_scene_to_packed(Level9)
	elif 10 == get_node("/root/Save").level:
		get_tree().change_scene_to_packed(Level10)
	elif 11 == get_node("/root/Save").level:
		#bugged title screen
		get_tree().change_scene_to_packed(Level11)

func ClearData_pressed():
	$Canvas/CurrentLevel.hide()
	get_node("/root/Save").level = 0
	$Background.show()
	$BackgroundBugged.hide()

extends CanvasLayer

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

func _ready():
	$AnimationFade.play("FadeIn")
	if get_node("/root/Save").level > 0:
		$CurrentLevel.show()
		$CurrentLevel.text = "Current Level: " +  str(get_node("/root/Save").level)

func toggle():
	$AnimationFade.play("FadeOut")
	
	await $AnimationFade.animation_finished
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


func ClearData_pressed():
	$CurrentLevel.hide()
	get_node("/root/Save").level = 0

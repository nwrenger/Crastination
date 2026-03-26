extends AnimationPlayer

func _ready():
	play("sun")
	advance(get_node("/root/Save").time)

func _exit_tree():
	get_node("/root/Save").time = current_animation_position

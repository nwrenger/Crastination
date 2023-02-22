extends Node2D


export var animationleft := false

func _ready():
	if animationleft:
		$Animation.current_animation = "movingleft"
	else:
		$Animation.current_animation = "movingright"

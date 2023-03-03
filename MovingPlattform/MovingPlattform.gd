extends Node2D

@export var animationleft := false

func _ready():
	if animationleft:
		$Animation.play("movingleft")
	else:
		$Animation.play("movingright")

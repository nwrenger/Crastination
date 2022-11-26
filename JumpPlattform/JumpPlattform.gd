extends Node2D

var jumped := false
var timer := 0.0

signal player_jump()

func _physics_process(delta):
#	print(timer)
	if jumped:
		jumped = false
		timer = 0.0
	else:
		timer += delta
	if $Area2D.get_overlapping_bodies():
		if timer >= 0.2:
			emit_signal("player_jump")
			jumped = true

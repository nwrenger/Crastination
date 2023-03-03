extends Node2D

signal player_killed_slime()

var already_dead := false


func head_entered(_body):
	if already_dead == false:
		emit_signal("player_killed_slime")
#		$Slime/Sprite2D/PointLight2D.hide()
		already_dead = true
		$MoveAnimation.stop(true)
		$Slime/Sprite2D.play("death")
		await $Slime/Sprite2D.animation_finished
		queue_free()


func dead_entered(_body):
	if already_dead == false:
		get_tree().reload_current_scene()

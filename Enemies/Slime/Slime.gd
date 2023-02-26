extends Node2D

signal player_killed_slime()

var already_dead := false


func head_entered(_body):
	if already_dead == false:
		emit_signal("player_killed_slime")
		$Slime/Sprite/Light2D.hide()
		already_dead = true
		$MoveAnimation.stop()
		$Slime/Sprite.play("death")
		yield($Slime/Sprite, "animation_finished")
		queue_free()


func dead_entered(_body):
	if already_dead == false:
		get_tree().reload_current_scene()

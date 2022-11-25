extends Node2D

signal player_killed_slime()

var already_dead := false

func _process(_delta):
#	print(already_dead)
	if already_dead == false:
		if $Slime/dead.get_overlapping_bodies():
#        	print($Slime/dead.get_overlapping_bodies())
			get_tree().reload_current_scene()

	if $Slime.position.x > 30:
		$Slime/Sprite.flip_h = false
	elif $Slime.position.x < -30:
		$Slime/Sprite.flip_h = true

func head_entered(_body):
	if already_dead == false:
		emit_signal("player_killed_slime")
		$Slime/Sprite/Light2D.hide()
		already_dead = true
		$MoveAnimation.stop()
		$Slime/Sprite.play("death")
		yield($Slime/Sprite, "animation_finished")
		queue_free()

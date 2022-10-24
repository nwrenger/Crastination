extends Node2D

signal player_killed_slime()

func _process(_delta):
    if $Slime/dead.get_overlapping_bodies():
#        print($Slime/dead.get_overlapping_bodies())
        get_tree().reload_current_scene()

    if $Slime.position.x > 30:
        $Slime/Sprite.flip_h = false
    elif $Slime.position.x < -30:
        $Slime/Sprite.flip_h = true

func head_entered(_body):
        emit_signal("player_killed_slime")
        $Slime/dead.set_deferred("monotoring", false)
        $Slime/dead.set_deferred("monotorable", false)
        $Slime/head.set_deferred("monotoring", false)
        $Slime/head.set_deferred("monotorable", false)
        $Slime/Collision.set_deferred("disabled", true)
        $MoveAnimation.stop()
        $Slime/Sprite.play("death")
        yield($Slime/Sprite, "animation_finished")
        queue_free()

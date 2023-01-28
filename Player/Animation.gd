extends AnimatedSprite

var animation_finished = false

func nplay(anim):
	if anim != animation:
		play(anim)

func _on_Player_move(velocity, on_ground, wall_right, wall_left):
	if wall_right:
		if Input.is_action_pressed("ui_left"):
			nplay("walllook")
		else:
			nplay("wall")
		flip_h = false
	if wall_left:
		if Input.is_action_pressed("ui_right"):
			nplay("walllook")
		else:
			nplay("wall")
	if velocity.x >= 100:
		if on_ground:
			nplay("run")
		flip_h = false
	if velocity.x <= -100:
		if on_ground:
			nplay("run")
		flip_h = true
	if velocity.y < 0:
		nplay("jump")
		animation_finished = false
	if velocity.y > 50 and wall_left == false and wall_right == false:
			nplay("readyfalling")
	if velocity.x < 100 and velocity.x > -100 and velocity.y > -1 and velocity.y < 26 and on_ground:
		if animation == "readyfalling":
			nplay("jumplanding")
		if animation == "jumplanding" and frame == 2 or animation == "run":
			nplay("idle")

func _on_Sprite_animation_finished():
	animation_finished = true

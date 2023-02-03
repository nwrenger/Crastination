extends AnimatedSprite

var left_run
var right_run

func nplay(anim):
	if anim != animation:
		play(anim)

func _on_Player_move(velocity, wall_right, wall_left, on_ground):
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
		flip_h = true
	if Input.is_action_pressed("ui_left") and wall_right == false:
		if on_ground:
			nplay("run")
		flip_h = true
	if Input.is_action_pressed("ui_right") and wall_left == false:
		if on_ground:
			nplay("run")
		flip_h = false
	if Input.is_action_just_pressed("ui_up"):
		nplay("jump")
	if velocity.y > 100 and wall_left == false and wall_right == false:
			nplay("readyfalling")
	if Input.is_action_pressed("ui_left") == false and Input.is_action_pressed("ui_right") == false and velocity.y > -1 and velocity.y < 26 and on_ground:
		if animation == "readyfalling":
			nplay("jumplanding")
		if animation == "jumplanding" and frame == 2 or animation == "run":
			print(animation)
			nplay("idle")


func _on_Player_upitgoes():
	nplay("jump")

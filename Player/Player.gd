extends CharacterBody2D

@export var on_ground := false
@export var player_speed := 350.0
@export var jump_height := -550
@export var gravity := 1500
@export var fall_speed_limit := 500
@export var friction := 0.1
@export var acceleration := 0.13

var jump_timer := 0.0
var notwall := false

var dash_left := false
var dash_right := false
var dash_speed := 900
var dash_total := 0.2
var dash_timer := 0.0
var double_press_total := 0.2
var double_press_timer_left := 0.5
var double_press_timer_right := 0.5
var press_count_right = 0
var press_count_left = 0
var cool_down := 0.0

var wall_right := false
var wall_left := false
var wall_fall_speed := 120

#for Animation Script, ignore connection error
signal move
signal upitgoes

func get_input():
	var dir = 0.0
	if Input.is_action_pressed("ui_right"):
		if notwall:
			dir += 1.0
	if Input.is_action_pressed("ui_left"):
		if notwall:
			dir -= 1.0
	if Input.is_key_pressed(KEY_R):
		get_tree().reload_current_scene()
	if dir != 0.0:
		velocity.x = lerp(velocity.x, dir * player_speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)

func _physics_process(delta):
	get_input()

#dash
	if get_node("/root/Save").dash:
		if Input.is_action_just_pressed("ui_right"):
			double_press_timer_right = 0
			press_count_right = press_count_right + 1
		else:
			double_press_timer_right += delta
			if double_press_timer_right >= dash_total:
				press_count_right = 0
		if not Input.is_action_pressed("ui_left") and not dash_right and press_count_right == 2:
				dash_right = true
#				print("dash right")
		if Input.is_action_just_pressed("ui_left"):
			double_press_timer_left = 0
			press_count_left = press_count_left + 1
		else:
			double_press_timer_left += delta
			if double_press_timer_left >= dash_total:
				press_count_left = 0
		if not Input.is_action_pressed("ui_right") and not dash_left and press_count_left == 2:
				dash_left = true
#				print("dash left")
		if notwall and cool_down <= 0:
			if dash_right:
				dash_timer += delta
				if dash_timer < dash_total:
					$dash_mist.emitting = true
					velocity.x = dash_speed
				else:
					dash_right = false
					$dash_mist.emitting = false
					cool_down = 0.5
			elif dash_left:
				dash_timer += delta
				if dash_timer < dash_total:
					$dash_mist.emitting = true
					velocity.x = -dash_speed
				else:
					$dash_mist.emitting = false
					dash_left = false
					cool_down = 0.5
			else:
				dash_timer = 0
		else:
			dash_right = false
			dash_left = false
			cool_down -= delta
			$dash_mist.emitting = false
#	print(double_press_timer)


#wall_jump
	if $WallLeft.get_overlapping_bodies():
		wall_left = true
	else:
		wall_left = false
	if $WallRight.get_overlapping_bodies():
		wall_right = true
	else:
		wall_right = false
	if wall_right or wall_left:
		notwall = false
	else:
		notwall = true

	$WallLeft/SlideParticles.emitting = wall_left
	$WallRight/SlideParticles.emitting = wall_right
	$WallLeft/SlideParticles2.emitting = wall_left
	$WallRight/SlideParticles2.emitting = wall_right

	if wall_left == false and wall_right == false and dash_left == false and dash_right == false:
		if not velocity.y >= fall_speed_limit or is_on_floor():
			velocity.y += gravity * delta
	else:
		on_ground = false
		if Input.is_action_just_pressed("ui_up") and wall_left:
			if Input.is_action_pressed("ui_right"):
				velocity.x += player_speed * 1.7
			else:
				velocity.x += player_speed/1.4
			velocity.y += jump_height
		elif Input.is_action_just_pressed("ui_up") and wall_right:
			if Input.is_action_pressed("ui_left"):
				velocity.x -= player_speed * 1.7
			else:
				velocity.x -= player_speed/1.4
			velocity.y += jump_height
		else:
			var wall_fall_speed_final
			if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
				wall_fall_speed_final =  wall_fall_speed/2.5
			elif Input.is_action_pressed("ui_down"):
				wall_fall_speed_final = wall_fall_speed * 2.5
			else:
				wall_fall_speed_final = wall_fall_speed
			velocity.y = wall_fall_speed_final

#velocity
#	print(velocity)
	move_and_slide()
#frame_anim
	emit_signal("move", velocity, wall_right, wall_left, on_ground, dash_right, dash_left, jump_timer)

	if is_on_floor() and not on_ground:
		on_ground = true

	$WallLeft/Collision.disabled = is_on_floor()
	$WallRight/Collision.disabled = is_on_floor()

#jump
	if is_on_floor():
		jump_timer = 0.0
	else:
		jump_timer += delta

	if Input.is_action_just_pressed("ui_up") and jump_timer < 0.15 and on_ground:
		wall_left = false
		wall_right = false
		velocity.y = jump_height
		on_ground = false




func player_killed_slime():
	velocity.y = jump_height * 1.4
	on_ground = false
	emit_signal("upitgoes")

func player_jump():
	velocity.y = jump_height * 2.35
	on_ground = false
	emit_signal("upitgoes")

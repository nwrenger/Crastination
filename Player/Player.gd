extends KinematicBody2D

export var on_ground := false
export (int) var player_speed = 350
export (int) var jump_height = -550
export (int) var gravity = 1500
export (int) var fall_speed_limit = 500
export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.13

var velocity = Vector2.ZERO
var jump_timer := 0.0

var wall_right := false
var wall_left := false
var wall_fall_speed := 120

func _ready():
	$Animation.play("FadeIn")

func get_input():
	var dir = 0
	if Input.is_action_pressed("ui_right"):
		dir += 1
		$Sprite.flip_h = false
		wall_left = false
		if on_ground and not wall_right and not wall_left:
			if $Sprite.animation != "jump":
				if $Sprite.animation != "jumplanding":
					$Sprite.play("run")
	if Input.is_action_pressed("ui_left"):
		dir -= 1
		$Sprite.flip_h = true
		wall_right = false
		if on_ground and not wall_right and not wall_left:
			if $Sprite.animation != "jump":
				if $Sprite.animation != "jumplanding":
					$Sprite.play("run")
		#only temporarly
	if Input.is_key_pressed(KEY_R):
		get_tree().reload_current_scene()
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * player_speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
		if on_ground:
			if $Sprite.animation != "jump":
				if $Sprite.animation != "jumplanding":
					$Sprite.play("idle")

func _physics_process(delta):
	get_input()

#    print($Sprite.animation)

	if $WallLeft.get_overlapping_bodies():
		wall_left = true
		$Sprite.flip_h = true
	else:
		wall_left = false
	if $WallRight.get_overlapping_bodies():
		wall_right = true
		$Sprite.flip_h = false
	else:
		wall_right = false



#    print(wall_left, wall_right)
	$WallLeft/SlideParticles.emitting = wall_left
	$WallRight/SlideParticles.emitting = wall_right
	if wall_left == false and wall_right == false:
		if not velocity.y >= fall_speed_limit or is_on_floor():
			velocity.y += gravity * delta
	else:
		on_ground = false
		if Input.is_action_just_pressed("ui_up") and wall_left:
			if Input.is_action_pressed("ui_left"):
				velocity.x += player_speed
			else:
				velocity.x += player_speed/1.4
			velocity.y += jump_height
		elif Input.is_action_just_pressed("ui_up") and wall_right:
			if Input.is_action_pressed("ui_left"):
				velocity.x -= player_speed
			else:
				velocity.x -= player_speed/1.4
			velocity.y += jump_height
		else:
			var wall_fall_speed_final
			if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
				wall_fall_speed_final =  wall_fall_speed/2
			else:
				wall_fall_speed_final = wall_fall_speed
			velocity.y = wall_fall_speed_final
			$Sprite.play("wall")

#    print(velocity)
	velocity = move_and_slide(velocity, Vector2.UP)
#    print(on_ground)        if not $Sprite.animation == "idle":
#sets on_ground once true when on ground
	if is_on_floor() and not on_ground:
		on_ground = true
		$Sprite.play("jumplanding")
#Makes sure that Wall Jump is not avalible when pn floor
	$WallLeft/Collision.disabled = is_on_floor()
	$WallRight/Collision.disabled = is_on_floor()
#    print($WallLeft/Collision.disabled, $WallRight/Collision.disabled)
#small jump delay after on_ground
	if is_on_floor():
		jump_timer = 0.0
	else:
		jump_timer += delta

	if Input.is_action_just_pressed("ui_up") and jump_timer < 0.15 and on_ground:
		wall_left = false
		wall_right = false
		velocity.y = jump_height
		on_ground = false
		$Sprite.play("jump")

func animation_finished():
	if $Sprite.animation != "jump":
		if $Sprite.animation != "run" and on_ground:
				$Sprite.play("idle")

func player_killed_slime():
	$Sprite.play("jump")
	on_ground = false
	velocity.y = jump_height * 1.4

func player_jump():
	$Sprite.play("jump")
	on_ground = false
	velocity.y = jump_height * 2.35

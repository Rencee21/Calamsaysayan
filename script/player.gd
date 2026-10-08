extends CharacterBody2D
class_name Player

const SPEED = 180
var current_dir = "down"
var input_locked = false
var input_enabled: bool = true

func _physics_process(delta):
	if input_locked or not input_enabled:
		velocity = Vector2.ZERO
		play_anim(false)
		move_and_slide()
		return
		
	player_movement()
	move_and_slide()

func player_movement():
	var moving = false

	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		velocity = Vector2(SPEED, 0)
		moving = true
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		velocity = Vector2(-SPEED, 0)
		moving = true
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		velocity = Vector2(0, -SPEED)
		moving = true
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		velocity = Vector2(0, SPEED)
		moving = true
	else:
		velocity = Vector2.ZERO

	play_anim(moving)

func play_anim(is_moving: bool):
	var anim = $AnimatedSprite2D

	if current_dir == "right":
		if is_moving:
			anim.play("right_walk")
		else:
			anim.play("right_idle")

	elif current_dir == "left":
		if is_moving:
			anim.play("left_walk")
		else:
			anim.play("left_idle")

	elif current_dir == "up":
		if is_moving:
			anim.play("front_walk")
		else:
			anim.play("front_idle")

	elif current_dir == "down":
		if is_moving:
			anim.play("back_walk")
		else:
			anim.play("back_idle")

func _disable_input():
	input_enabled = false

func _enable_input():
	input_enabled = true
	
func move_towards(target_position: Vector2, delta: float):
	var direction = (target_position - global_position).normalized()
	velocity = direction * SPEED
	move_and_slide()

	# Determine facing direction for animation
	if abs(direction.x) > abs(direction.y):
		current_dir = "right" if direction.x > 0 else "left"
	else:
		current_dir = "down" if direction.y > 0 else "up"

	play_anim(true)

	# Return true if close enough to target
	return global_position.distance_to(target_position) < 5.0

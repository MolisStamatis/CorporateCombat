extends KinematicBody2D

export var speed = 350
export var dash_speed = 1200
export var dash_acceleration = 2000
export var dash_deceleration = 1000
export var dash_duration = 0.2
export var dash_cooldown = 1.0

export var dash_timer = 0.0
export var is_dashing = false
export var dash_direction = Vector2()

export var velocity = Vector2()

func _process(delta):
	dash_timer = max(0, dash_timer - delta)

	if is_dashing:
		dash_timer -= delta
		velocity = dash_direction * dash_speed
	else:
		process_input()

	move_and_slide(velocity, Vector2(0, -1))

func process_input():
	velocity = Vector2()

	if Input.is_action_pressed("Right"):
		velocity.x += 1
	if Input.is_action_pressed("Left"):
		velocity.x -= 1
	if Input.is_action_pressed("Down"):
		velocity.y += 1
	if Input.is_action_pressed("Up"):
		velocity.y -= 1

	velocity = velocity.normalized() * speed

	if Input.is_action_pressed("Dash") and dash_timer <= 0:
		start_dash()

func start_dash():
	is_dashing = true
	dash_direction = velocity.normalized()
	dash_timer = dash_duration

func _physics_process(delta):
	if is_dashing:
		velocity = velocity.linear_interpolate(dash_direction * dash_speed, delta * dash_acceleration)

		if dash_timer <= 0:
			is_dashing = false
			dash_timer = dash_cooldown
	else:
		velocity = velocity.linear_interpolate(Vector2(), delta * dash_deceleration)

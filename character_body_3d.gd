extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var move_direction := Vector3.ZERO


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('up'):
		move_direction += Vector3.FORWARD
	elif event.is_action_pressed('down'):
		move_direction += Vector3.BACK
	elif event.is_action_pressed('left'):
		move_direction += Vector3.LEFT
	elif event.is_action_pressed('right'):
		move_direction += Vector3.RIGHT

	if event.is_action_released('up'):
		move_direction.z = 0
	elif event.is_action_released('down'):
		move_direction.z = 0
	elif event.is_action_released('left'):
		move_direction.x = 0
	elif event.is_action_released('right'):
		move_direction.x = 0

	if event.is_action_pressed('jump') and is_on_floor():
		move_direction += Vector3.UP * JUMP_VELOCITY

	#move_direction = Input.get_vector('left', 'right', 'up', 'down')


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	#var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := transform.basis * move_direction.normalized()
	if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		velocity.y += direction.y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_direction.y = 0

	move_and_slide()

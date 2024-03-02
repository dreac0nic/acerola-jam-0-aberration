class_name QuakeBody3D
extends CharacterBody3D


const SMALLEST_MOVEMENT_THRESHOLD = 1e-05


func gravity(delta: float, ratio: float = 1.0, direction: Vector3 = Vector3.DOWN) -> void:
	velocity += ratio*direction*ProjectSettings.get_setting("physics/3d/default_gravity")*delta


func poll_direction(direction_transform: Transform3D = global_transform) -> Vector3:
	var direction = Input.get_vector("strafe_left", "strafe_right", "move_forward", "move_backward")

	direction = direction_transform.basis*Vector3(direction.x, 0.0, direction.y)

	return direction.normalized() if direction.length_squared() > 1 else direction


func accelerate(wishdir: Vector3, max_speed: float, accel: float, delta: float) -> void:
	var flat_velocity = Vector3(velocity.x, 0.0, velocity.z)
	var speed = flat_velocity.dot(wishdir)
	var speed_delta = clamp(max_speed - speed, 0, accel*delta)

	velocity += wishdir*speed_delta


func drag_motion(drag: float, delta: float) -> void:
	var flat_velocity = Vector3(velocity.x, 0.0, velocity.z)
	var flat_speed = flat_velocity.length()

	if flat_speed != 0:
		var input_drag = flat_speed*drag*delta

		velocity = Vector3(0, velocity.y, 0) + flat_velocity*max(flat_speed - input_drag, 0)/flat_speed
	elif flat_speed < SMALLEST_MOVEMENT_THRESHOLD:
		velocity = Vector3(0, velocity.y, 0)

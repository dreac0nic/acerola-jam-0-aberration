extends Node3D


signal look(current_look, frame_look)
signal look_percent(current_look, frame_look)
signal turning(current_direction, frame_turn)


const MOUSELOOK_MODIFIER = 4 ## Freelook modifier for mouse to scale values to a reasonable scale
const JOYLOOK_MODIFIER = 100 ## Freelook modifier for joystick to lscale values to match mouse


@export var pivot_node: Node3D ## Base node to rotate for hoizontal input
@export_range(1.0, 10.0, 0.1, "or_greater") var sensitivity: float = 1.0


var frame_camera_motion: Vector2 = Vector2.ZERO


func _input(event):
	if event is InputEventMouseMotion and can_look():
		frame_camera_motion += event.relative


func _physics_process(delta):
	var accumulated_look = MOUSELOOK_MODIFIER*frame_camera_motion
	accumulated_look += JOYLOOK_MODIFIER*Input.get_vector("turn_left", "turn_right", "look_up", "look_down")
	accumulated_look *= -1*sensitivity*delta

	accumulated_look.x = deg_to_rad(accumulated_look.x)
	accumulated_look.y = deg_to_rad(accumulated_look.y)

	pivot_node.rotate_y(accumulated_look.x)
	rotate_x(accumulated_look.y)

	rotation.x = clamp(rotation.x, -PI/2, PI/2)

	frame_camera_motion = Vector2.ZERO ## reset accumulator for next frame

	look.emit(rotation.x, accumulated_look.y)
	look_percent.emit(rotation.x/(PI/2), accumulated_look.y/(PI/2)) # XXX: Technically, the frame value here should be clamped to the amount acctually moved
	turning.emit(pivot_node.global_rotation.y, accumulated_look.x)


func can_look() -> bool:
	return Input.mouse_mode == Input.MOUSE_MODE_CAPTURED

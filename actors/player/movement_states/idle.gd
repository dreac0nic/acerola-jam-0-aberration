class_name IdleState
extends GroundState


@export var walk_state: BaseState ## State to transition to walking
@export var sprint_state: BaseState ## State to transition to sprinting


func _move_input(event: InputEvent) -> BaseState:
	var move = Input.get_vector("strafe_left", "strafe_right", "move_forward", "move_backward")
	var super_state = super._move_input(event)

	if super_state:
		return super_state
	elif move.length_squared() >= player_body.SMALLEST_MOVEMENT_THRESHOLD:
		return sprint_state if Input.is_action_pressed("sprint") else walk_state
	else:
		return null

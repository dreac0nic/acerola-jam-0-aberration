class_name WalkState
extends MoveState


@export var invert_input_check:  bool = false ## Inverses the check against the sprint input state
@export var sprint_state: BaseState ## State to transition to sprint


func _move_input(event: InputEvent) -> BaseState:
	var parent_state = super._move_input(event)

	if parent_state:
		return parent_state

	return sprint_state if Input.is_action_pressed("sprint") != invert_input_check else null

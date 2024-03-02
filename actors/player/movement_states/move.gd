class_name MoveState
extends GroundState


@export var idle_state: BaseState ## State to transition to for idling
@export var maximum_speed: float = 5.0 ## The top speed while moving
@export var acceleration: float = 50.0 ## The acceleration applied by player input


func _move_physics_process(delta: float) -> BaseState:
	var wishdir = player_body.poll_direction()

	if not player_body.is_on_floor():
		return air_state

	player_body.gravity(delta)
	player_body.drag_motion(drag, delta)
	player_body.accelerate(wishdir, maximum_speed, acceleration, delta)

	player_body.move_and_slide()

	return idle_state if wishdir.length_squared() < player_body.SMALLEST_MOVEMENT_THRESHOLD else null

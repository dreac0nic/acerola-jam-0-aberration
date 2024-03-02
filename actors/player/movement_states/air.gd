class_name AirState
extends BaseState


@export var idle_state: BaseState ## State to transition to when idle
@export var walk_state: BaseState ## State to transition to when walking
@export var sprint_state: BaseState ## State to transition to when sprinting
@export var air_speed: float = 0.6 ## Player's allowed air speed
@export var acceleration: float = 50.0 ## Player's air acceleration


func _move_physics_process(delta: float) -> BaseState:
	var wishdir = player_body.poll_direction()

	player_body.gravity(delta)
	player_body.accelerate(wishdir, air_speed, acceleration, delta)

	player_body.move_and_slide()

	if player_body.is_on_floor():
		if wishdir.length_squared() < player_body.SMALLEST_MOVEMENT_THRESHOLD:
			return idle_state
		elif Input.is_action_pressed("sprint"):
			return sprint_state
		else:
			return walk_state

	return null

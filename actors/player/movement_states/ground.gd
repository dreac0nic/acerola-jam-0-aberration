class_name GroundState
extends BaseState


@export var air_state: BaseState ## State to transition to falling/air motion
@export var jump_state: BaseState ## State to transition to for jumping
@export var drag: float = 6.0 ## General-purpose player input drag


func _move_input(event: InputEvent) -> BaseState:
	return jump_state if event.is_action_pressed("jump") else null


func _move_physics_process(delta: float) -> BaseState:
	player_body.gravity(delta)
	player_body.drag_motion(drag, delta)

	player_body.move_and_slide()

	return air_state if not player_body.is_on_floor() else null

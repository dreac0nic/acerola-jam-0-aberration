extends Node


signal changed_state(state)


@export var starting_state: BaseState ## A startingstate for this machine


var current_state: BaseState


func _ready():
	change_state(starting_state)


func change_state(target_state: BaseState):
	if current_state:
		current_state._move_exit()

	current_state = target_state
	current_state._move_enter()

	changed_state.emit(current_state)


func _physical_process(delta: float):
	var trans_state = current_state._move_physics_process(delta)

	if trans_state:
		change_state(trans_state)


func _process(delta: float):
	var trans_state = current_state._move_process(delta)

	if trans_state:
		change_state(trans_state)


func _input(event: InputEvent):
	var trans_state = current_state._move_input(event)

	if trans_state:
		change_state(trans_state)

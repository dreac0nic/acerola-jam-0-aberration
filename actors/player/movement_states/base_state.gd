class_name BaseState
extends Node


@export var player_body: CharacterBody3D ## Target player body to control


func _move_enter():
	pass


func _move_exit():
	pass


func _move_physics_process(_delta: float) -> BaseState:
	return null


func _move_process(_delta: float) -> BaseState:
	return null


func _move_input(_event: InputEvent) -> BaseState:
	return null

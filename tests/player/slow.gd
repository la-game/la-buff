@tool
extends Effect2D


func calculate(value):
	if Input.is_action_pressed("crouch"):
		return value * 0.5
	return value

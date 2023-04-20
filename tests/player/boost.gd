@tool
extends Effect2D


func calculate(value):
	if Input.is_action_pressed("run"):
		return value + 200
	return value

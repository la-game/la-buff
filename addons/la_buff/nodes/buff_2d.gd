@icon("../icons/buff_2d.svg")
class_name Buff2D
extends Node2D


signal ending

@export var buff_name: String

@export var stack: bool = true

@export var refresh: bool = true

var ended: bool = false:
	get:
		if not ended and has_timeouted():
			ended = true
		return ended
	set(should_end):
		if should_end and not is_queued_for_deletion():
			ended = true
			ending.emit()
			queue_free()


func calculate(value, status: StringName, operation: StringName):
	var effects = _get_effects()
	
	for effect in effects:
		if effect.status == status and effect.operation == operation:
			value = effect.calculate(value)
	
	return value


func has_timeouted() -> bool:
	return true


func _get_effects():
	return get_children().filter(func(c): return c is Effect2D)

@tool
@icon("../icons/buff_2d.svg")
class_name Buff2D
extends Node2D


signal ending

@export var buff_name: StringName

@export var stack: bool = true

@export var refresh: bool = true

var ended: bool = false:
	get:
		if not ended and call("has_timeouted"):
			ended = true
		return ended
	set(should_end):
		if should_end and not is_queued_for_deletion():
			ended = true
			ending.emit()
			queue_free()


func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	var buff = Buff2D.new()
	var user_script: Resource = get_script()
	var buff_script: Resource = buff.get_script()
	
	buff.free()
	
	if user_script.resource_path == buff_script.resource_path:
		warnings.append("Replace this script for one that extends Buff2D.")
	
	if not has_method("has_timeouted"):
		warnings.append('Missing method "has_timeouted" that returns boolean.')
	
	return warnings


func calculate(value, status: StringName, operation: StringName):
	var effects = _get_effects()
	
	for effect in effects:
		if effect.status == status and effect.operation == operation:
			value = effect.calculate(value)
	
	return value


func _get_effects() -> Array[Effect2D]:
	var effects: Array[Effect2D]
	effects.assign(get_children().filter(func(c): return c is Effect2D))
	return effects

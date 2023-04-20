@tool
@icon("../icons/effect_2d.svg")
class_name Effect2D
extends Node2D


@export var operation: StringName

@export var status: StringName


func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	var effect = Effect2D.new()
	var user_script: Resource = get_script()
	var effect_script: Resource = effect.get_script()
	
	effect.free()
	
	if user_script.resource_path == effect_script.resource_path:
		warnings.append("Replace this script for one that extends Effect2D.")
	
	if not has_method("calculate"):
		warnings.append('Missing method "calculate" that returns variant.')
	
	return warnings

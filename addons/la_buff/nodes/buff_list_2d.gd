@icon("../icons/buff_list_2d.svg")
class_name BuffList2D
extends Node2D


@export var operations: Array[StringName] = [
	"precondition",
	"addition",
	"multiplication",
	"postcondition",
]


func _ready():
	child_entered_tree.connect(_add_buff)


func calculate(value, status: StringName):
	var buffs = _get_buffs()
	
	for operation in operations:
		for buff in buffs:
			if not buff.ended:
				value = buff.calculate(value, status, operation)
	
	return value


func _add_buff(buff: Buff2D):
	if not buff.stack:
		for b in _get_buffs_named(buff.buff_name):
			b.ended = true
	
	if not buff.refresh:
		if _get_buffs_named(buff.buff_name).is_empty():
			buff.queue_free()


func _get_buffs() -> Array[Buff2D]:
	return get_children().filter(func(c): return c is Buff2D)


func _get_buffs_named(buff_name: StringName) -> Array[Buff2D]:
	return _get_buffs().filter(func(b): return b.buff_name == buff_name)


func _on_child_entered_tree(node: Node):
	if node is Buff2D:
		_add_buff(node)

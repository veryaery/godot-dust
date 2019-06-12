class_name Dust

var Type = preload("res://Type.gd");

var type;
var behaviour;

func _init(_type: Type):
	type = _type;
	behaviour = _type.behaviour_node.duplicate();
	pass
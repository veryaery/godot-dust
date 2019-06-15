extends Node

const game_scene = "res://game.tscn";

var types = {};

onready var types_node = $"../types";

func _ready():
	_load_types();
	get_tree().change_scene(game_scene);

func _load_types():
	for child in types_node.get_children():
		var type = child.duplicate();
		types[type.id] = type;
		print("Loaded {0} (id: {1})".format([ type.name, type.id ]));
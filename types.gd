extends Node

func _ready():
	for child in get_children():
		var type = child.duplicate();
		type.behaviour_node = child.behaviour_node.duplicate();
		main.types[child.id] = type;
		print("Loaded type - " + type.name);
	main.types_ready();
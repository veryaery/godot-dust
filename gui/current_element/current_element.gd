extends Node

export(NodePath) var color_node_path;
onready var color_node = get_node(color_node_path);

export(NodePath) var name_node_path;
onready var name_node = get_node(name_node_path);

var style = StyleBoxFlat.new();

func _ready():
	color_node.add_stylebox_override("normal", style);
	color_node.add_stylebox_override("hover", style);
	color_node.add_stylebox_override("pressed", style);

func change_dust():
	style.set_bg_color(main.selected_type.color);
	color_node.update();
	
	name_node.text = main.selected_type.name;
	name_node.update();
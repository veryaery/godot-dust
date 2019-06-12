extends Control

export(NodePath) var game_node_path;
onready var game_node = get_node(game_node_path);

func _on_color_pressed():
	game_node.change_dust();
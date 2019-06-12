class_name Type

extends Node

export(String) var id;
export(Color) var color;
export(NodePath) var behaviour_node_path;

onready var behaviour_node = get_node(behaviour_node_path);
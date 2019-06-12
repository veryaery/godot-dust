extends Node

const size_x = 60;
const size_y = 60;

var Dust = preload("res://Dust.gd");

var types = {};
var dusts = {};
var selected_type;
var selected_type_i = 0;
var simulation_interval = 0.1;

func _ready():
	randomize();

func types_ready():
	selected_type = types[types.keys()[selected_type_i]];
	clear(size_x, size_y);
	get_tree().change_scene("res://game.tscn");

func clear(size_x: int, size_y: int):
	for x in range(size_x):
		dusts[x] = {};
		for y in range(size_y):
			dusts[x][y] = null;

func get_dust(x: int, y: int):
	return dusts[x][y] or null;

func set_dust(x: int, y: int, dust: Dust):
	dusts[x][y] = dust;

func change_dust():
	selected_type_i += 1;
	if selected_type_i == types.keys().size():
		selected_type_i = 0;
	selected_type = types[types.keys()[selected_type_i]];
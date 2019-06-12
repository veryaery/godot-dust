extends Node2D

export(NodePath) var current_element_node_path;
onready var current_element_node = get_node(current_element_node_path);

var current_simulation_interval = 0;

func _ready():
	current_element_node.change_dust();

func _process(d):
	current_simulation_interval += d;
	
	if (current_simulation_interval > main.simulation_interval):
		current_simulation_interval = 0;
		simulate();

func simulate():
	for x in range(main.dusts.keys().size()):
		for y in range(main.dusts[x].keys().size()):
			var dust = main.dusts[x][y];
			
			if dust:
				dust.behaviour.simulated = false;
	
	for x in range(main.dusts.keys().size()):
		for y in range(main.dusts[x].keys().size()):
			var dust = main.dusts[x][y];
			
			if dust and not dust.behaviour.simulated:
				dust.behaviour.simulate(x, y);
				dust.behaviour.simulated = true;

func change_dust():
	main.change_dust();
	current_element_node.change_dust();
extends Node

export(int) var density;
export(int) var support;
export(bool) var solid;
export(bool) var stationary;

var simulated;

var x;
var y;

func simulate(_x: int, _y: int):
	x = _x;
	y = _y;
	
	if not stationary:
		simulate_density();

func simulate_density():
	if density > 0:
		var down = relative(0, 1);
	
		if (
			(down and density > down.behaviour.density and not down.behaviour.stationary) or
			(not down and density > 0)
		):
			move_to(x, y + 1);
		else:
			simulate_support();
	elif density < 0:
		var up = relative(0, -1);
		
		if not up:
			move_to(x, y - 1);
		else:
			simulate_support();

func simulate_support():
	var no_support = { 0: true, 1: true, 2: true, 3: true };
	
	for i in range(support + 1):
		for corner_i in range(4):
			if no_support.has(corner_i):
				var corner = match_corner(corner_i);
				var corner_x = int(x + corner[0]);
				var corner_y = int(y + corner[1] * i);
				
				if within(corner_x, corner_y):
					var dust = main.dusts[corner_x][corner_y];
					
					if dust:
						if (
							(corner[1] > 0 and dust.behaviour.density >= density) or
							(corner[1] < 0 and dust.behaviour.density <= density) or
							dust.behaviour.stationary
						):
							no_support.erase(corner_i);
					elif (corner[1] > 0 and density <= 0) or (corner[1] < 0 and density >= 0):
						no_support.erase(corner_i);
	
	if no_support.keys().size() > 0:
		var corner_i = no_support.keys()[floor(randf() * no_support.keys().size())];
		var corner = match_corner(corner_i);
		var corner_x = int(x + corner[0]);
		var corner_y = y;
		
		move_to(corner_x, corner_y);

func match_corner(corner_i):
	match corner_i:
		0:
			return Vector2(-1, -1);
		1:
			return Vector2(1, -1);
		2:
			return Vector2(-1, 1);
		3:
			return Vector2(1, 1);

func relative(dx: int, dy: int):
	if within(x + dx, y + dy):
		return main.dusts[x + dx][y + dy];
	else:
		return null;

func move_to(to_x: int, to_y: int):
	if within(x, y):
		if within(to_x, to_y):
			var to = main.dusts[to_x][to_y];
			main.dusts[to_x][to_y] = main.dusts[x][y];
			main.dusts[x][y] = to;
		else:
			main.dusts[x][y] = null;
	
	x = to_x;
	y = to_y;

func within(x, y):
	return (
		x >= 0 and x < main.dusts.keys().size() and
		y >= 0 and y < main.dusts[x].keys().size()
	);
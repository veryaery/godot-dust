extends Node2D

const dust_scale = 10; # How many pixels per dust

var Dust = preload("res://Dust.gd");

var cursors = {};

func _process(d):
	update();

func _draw():
	for x in range(main.dusts.keys().size()):
		for y in range(main.dusts[x].keys().size()):
			var dust = main.dusts[x][y];
			
			if dust:
				draw_rect(Rect2(x * dust_scale, y * dust_scale, dust_scale, dust_scale), dust.type.color);

func _input(event):
	var i = event.index if event is InputEventScreenTouch or event is InputEventScreenDrag else 0;
	
	if event is InputEventMouseButton or event is InputEventScreenTouch:
		if event.pressed:
			cursors[i] = event.position;
			place_at(event.position[0], event.position[1]);
		else:
			cursors[i] = null;
	elif event is InputEventMouseMotion or event is InputEventScreenDrag:
		if cursors.has(i) and cursors[i]:
			var length = sqrt(abs(int(event.relative[0]) ^ 2) + abs(int(event.relative[1]) ^ 2));
			
			if length > 0:
				var normal_x = event.relative[0] / length;
				var normal_y = event.relative[1] / length;
				var x = cursors[i][0];
				var y = cursors[i][1];
				
				for j in range(ceil(length)):
					x += normal_x;
					y += normal_y;
					place_at(x, y);
				
				cursors[i] = event.position;

func place_at(x: float, y: float):
	if x > position[0] and x < position[0] + main.dusts.size() * dust_scale and main.dusts.size() > 0:
			if y > position[1] and y < position[1] + main.dusts[0].size() * dust_scale:
				var dust_x = floor((x - position[0]) / dust_scale);
				var dust_y = floor((y - position[1]) / dust_scale);
				
				if main.selected_type.id == "void":
					main.set_dust(dust_x, dust_y, null);
				else:
					main.set_dust(dust_x, dust_y, Dust.new(main.selected_type));
				update();
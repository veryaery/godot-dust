extends Panel

signal select;

var Type = preload("res://scripts/Type.gd");

const swipe_length = 0.3;

var type_button = preload("res://ui_components/type_button.tscn");
var buttons = [];
var button_types = [];
var selected;
var cursors = {};

onready var container = $HBoxContainer;
onready var selector = $"../selector";

func _ready():
	var types = main.types.values();
	for i in range(3):
		var button = type_button.instance().duplicate();
		var type = types[i];
		
		container.add_child(button);
		button.change_icon(type);
		button.connect("pressed", self, "_on_pressed");
		
		buttons.append(button);
		button_types.append(type);
	_select(0);

func change_selected_type(type: Type):
	var button = buttons[selected];
	
	button_types[selected] = type;
	button.change_icon(type);

func _on_pressed(button):
	_select(button.get_index());

func _select(i: int):
	var button = buttons[i];
	
	if selected != null:
		var previously_selected = buttons[selected];
		previously_selected.change_style(false);
	
	button.change_style(true);
	selected = i;
	emit_signal("select");

func _input(event):
	var i = event.index if event.get_property_list().has("index") else 0;
	
	if event is InputEventMouseButton or event is InputEventScreenTouch:
		if event.pressed:
			cursors[i] = event.position;
		else:
			cursors.erase(i);
	elif event is InputEventMouseMotion or event is InputEventScreenDrag:
		if cursors.has(i):
			var origin = cursors[i];
			var dy = origin[1] - event.position[1];
			
			if !selector.visible and dy > get_viewport_rect().size[1] * swipe_length and _within_hotbar(origin):
				selector.show();
			elif selector.visible and dy < get_viewport_rect().size[1] * -swipe_length:
				selector.hide();

func _within_hotbar(position):
	return (
		position[0] >= rect_position[0] and position[0] <= rect_position[0] + rect_size[0] and
		position[1] >= rect_position[1] and position[1] <= rect_position[1] + rect_size[1]
	);
extends Panel

var type_button = preload("res://ui_components/type_button.tscn");

var buttons = [];
var button_types = [];
var previously_selected;

onready var hotbar = $"../hotbar";
onready var container = $types/GridContainer;

onready var info_icon = $VBoxContainer/HBoxContainer/MarginContainer/icon;
onready var info_name = $VBoxContainer/HBoxContainer/MarginContainer2/name;
onready var info_description = $VBoxContainer/MarginContainer/description;

func _ready():
	for type in main.types.values():
		var button = type_button.instance().duplicate();
		
		container.add_child(button);
		button.change_icon(type);
		button.connect("pressed", self, "_on_pressed");
		
		buttons.append(button);
		button_types.append(type);
	hotbar.connect("select", self, "_select");
	_select();

func _on_pressed(button):
	var type = button_types[button.get_index()];
	
	hotbar.change_selected_type(type);
	_change_info(type);
	_change_selected(button.get_index());

func _select():
	var type = hotbar.button_types[hotbar.selected];
	var i = button_types.find(type);
	
	_change_info(type);
	_change_selected(i);

func _change_selected(i: int):
	var button = buttons[i];
	
	if previously_selected != null:
		previously_selected.change_style(false);
	
	button.change_style(true);
	
	previously_selected = button;

func _change_info(type):
	info_icon.texture = load("res://icons/{0}.png".format([ type.id ]));
	info_name.text = type.name;
	info_description.text = type.description;
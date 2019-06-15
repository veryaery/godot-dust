extends Panel

var type_button = preload("res://ui_components/type_button.tscn");
var buttons = [];
var selected;

onready var container = $HBoxContainer;

func _ready():
	for i in range(3):
		var button = type_button.instance().duplicate();
		container.add_child(button);
		button.connect("pressed", self, "_pressed");
		buttons.append(button);
	select(0);

func _pressed(button):
	select(button.get_index());

func select(i: int):
	var button = buttons[i];
	
	if selected != null:
		var previously_selected = buttons[selected];
		previously_selected.change_style(false);
	
	button.change_style(true);
	selected = i;
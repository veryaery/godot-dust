extends Panel

var type_button = preload("res://ui_components/type_button.tscn");

onready var container = $types/GridContainer;

func _ready():
	for type in main.types.values():
		var button = type_button.instance().duplicate();
		container.add_child(button);
		button.change_icon(load("res://icons/{0}.png".format([ type.id ])));
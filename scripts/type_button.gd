extends Control

signal pressed;

export(StyleBoxFlat) var style;
export(StyleBoxFlat) var selected_style;

var Type = preload("res://scripts/Type.gd");

const names = [ "normal", "hover", "pressed" ];

onready var button = $button;
onready var icon = $button/icon;

func _ready():
	button.connect("pressed", self, "_on_pressed");
	change_style(false);

func change_style(selected: bool):
	var overriding_style = selected_style if selected else style;
	
	for name in names:
		button.add_stylebox_override(name, overriding_style);

func change_icon(type: Type):
	icon.texture = load("res://icons/{0}.png".format([ type.id ]));

func _on_pressed():
	emit_signal("pressed", self);
shader_type canvas_item;

void fragment() {
	COLOR = vec4(0, 1, 0.5, cos(TIME * 2f + (FRAGCOORD.y - FRAGCOORD.x) / 20f));
}
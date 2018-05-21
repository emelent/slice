shader_type canvas_item;

uniform vec4 target_color: hint_color;
uniform vec4 change_color: hint_color;

void fragment(){
	vec4 colr = texture(TEXTURE, UV);
	if(colr == target_color)
		colr = change_color;
	COLOR = colr;
}
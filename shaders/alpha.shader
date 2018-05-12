shader_type canvas_item;

uniform float alpha: hint_range(0.0, 1.0);

void fragment(){
	vec4 colr = texture(TEXTURE, UV);
	COLOR = vec4(colr.rgb, colr.a * alpha);
}
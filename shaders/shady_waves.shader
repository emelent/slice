shader_type canvas_item;

uniform vec2 center;
void fragment()
{
	COLOR.rgb = vec3(0.0);
	COLOR.a = 0.80;
	center.x *= 100.0;
	if (distance(SCREEN_UV, center) < 0.1){	
		COLOR = texture(SCREEN_TEXTURE, SCREEN_UV);
	}
}
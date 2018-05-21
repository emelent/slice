shader_type canvas_item;
uniform float speed = 0.01;

void fragment(){
	COLOR.rgba = texture(TEXTURE,UV + vec2(mod(TIME*speed,1.0), 0.0)).rgba;
}

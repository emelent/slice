shader_type canvas_item;

uniform sampler2D displacement: hint_albedo;
uniform float magnitude: hint_range(0.0, 1.0);

void fragment(){
	vec2 disp = texture(displacement, SCREEN_UV).xy;
//	vec4 col = texture(SCREEN_TEXTURE, SCREEN_UV + vec2(0.0, sin(FRAGCOORD.x / 50.0 + TIME)/100.0));
	disp = ((disp * 2.0) - vec2(1.0)) * magnitude;
	vec4 col = texture(SCREEN_TEXTURE, SCREEN_UV + disp);
	COLOR = col;
}
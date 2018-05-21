shader_type canvas_item;

uniform sampler2D displacement: hint_albedo;
uniform float magnitude: hint_range(0.0, 1.0);

void fragment(){
	vec2 disp = texture(displacement, vec2(sin(UV.x + TIME/40.0), cos(UV.y + TIME/50.0))).xy;
	disp = ((disp * 2.0) - vec2(1.0)) * magnitude;
	vec4 col = texture(SCREEN_TEXTURE, SCREEN_UV + disp);
	COLOR = col;
}
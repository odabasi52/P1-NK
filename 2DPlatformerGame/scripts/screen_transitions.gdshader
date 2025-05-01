shader_type canvas_item;

uniform sampler2D wipeImage;
uniform float percent : hint_range(0.0, 1.0);

void fragment() {
	float tex_val = texture(wipeImage, UV).r;
	if (tex_val < percent){
		COLOR.a = 0.0;
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

shader_type spatial;

uniform float light_charge;
uniform vec3 start_color:source_color;
uniform vec3 end_color:source_color;

void vertex() {
	VERTEX.x+=0.01*sin(TIME*100.0)*light_charge;
	VERTEX.z+=0.01*sin(TIME*100.0)*light_charge;
}

void fragment() {
	ALBEDO = mix(start_color,end_color,light_charge);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}

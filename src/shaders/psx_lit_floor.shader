shader_type spatial; 
render_mode skip_vertex_transform, diffuse_lambert_wrap, specular_phong, ambient_light_disabled;

uniform vec4 color : hint_color;
uniform sampler2D albedoTex : hint_albedo;
uniform float specular_intensity : hint_range(0, 1);
uniform float resolution = 64;
uniform float cull_distance = 512;
uniform vec2 uv_scale = vec2(1.0, 1.0);
uniform vec2 uv_offset = vec2(.0, .0);

//varying vec4 vertex_coordinates;

void vertex() {
	UV = UV * uv_scale + uv_offset;
	
	float vertex_distance = length((MODELVIEW_MATRIX * vec4(VERTEX, 1.0)));
	
	VERTEX = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	float vPos_w = (PROJECTION_MATRIX * vec4(VERTEX, 1.0)).w;
	VERTEX.xy = vPos_w * floor(resolution * VERTEX.xy / vPos_w) / resolution;
	//vertex_coordinates = vec4(UV * VERTEX.z, VERTEX.z, .0);
	
	if (vertex_distance > cull_distance)
		VERTEX = vec3(.0);
}

void fragment() {
	vec4 tex = texture(albedoTex, UV.xy);
	
	ALBEDO = tex.rgb * color.rgb;
	SPECULAR = specular_intensity;
}
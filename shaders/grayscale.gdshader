shader_type canvas_item;

// --- Uniforms --- //
uniform bool use_grayscale = true;
uniform vec4 shift_color : source_color;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    // Captura lo que hay detrás del ColorRect
    vec4 screen_color = texture(SCREEN_TEXTURE, SCREEN_UV);
    
    // Aplica escala de grises al contenido capturado
    float gray = dot(screen_color.rgb, vec3(0.299, 0.587, 0.114));
    
    // Mezcla el color original con el valor en escala de grises según el booleano
    vec3 final_color = mix(screen_color.rgb, vec3(gray), float(use_grayscale));
    
    // Aplica el shift_color
    COLOR = vec4(final_color, screen_color.a) * shift_color;
}

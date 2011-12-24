#define KERNEL_SIZE 25

// Gaussian kernel
// 1 1 1 1 1
// 1 1 1 1 1
// 1 1 1 1 1
// 1 1 1 1 1
// 1 1 1 1 1
float kernel[KERNEL_SIZE];

uniform sampler2D src_tex_unit0;
uniform vec2 src_tex_offset0;

vec2 offset[KERNEL_SIZE];

void main(void)
{
    int i = 0;
    vec4 sum = vec4(0.0);

    offset[0] = vec2(-src_tex_offset0.s, -src_tex_offset0.t);
    offset[1] = vec2(0.0, -src_tex_offset0.t);
    offset[2] = vec2(src_tex_offset0.s, -src_tex_offset0.t);
    offset[3] = vec2(-src_tex_offset0.s, 0.0);
    offset[4] = vec2(0.0, 0.0);
   
    offset[5] = vec2(src_tex_offset0.s, 0.0);
    offset[6] = vec2(-src_tex_offset0.s, src_tex_offset0.t);
    offset[7] = vec2(0.0, src_tex_offset0.t);
    offset[8] = vec2(src_tex_offset0.s, src_tex_offset0.t);
    offset[9] = vec2(src_tex_offset0.s, src_tex_offset0.t);

    offset[10] = vec2(0.0, src_tex_offset0.t);
    offset[11] = vec2(0.0, src_tex_offset0.t);
    offset[12] = vec2(0.0, 0.0);
    offset[13] = vec2(0.0, src_tex_offset0.t);
    offset[14] = vec2(0.0, src_tex_offset0.t);

    offset[15] = vec2(src_tex_offset0.s, 0.0);
    offset[16] = vec2(-src_tex_offset0.s, src_tex_offset0.t);
    offset[17] = vec2(0.0, src_tex_offset0.t);
    offset[18] = vec2(src_tex_offset0.s, src_tex_offset0.t);
    offset[19] = vec2(src_tex_offset0.s, src_tex_offset0.t);

    offset[20] = vec2(src_tex_offset0.s, 0.0);
    offset[21] = vec2(-src_tex_offset0.s, src_tex_offset0.t);
    offset[22] = vec2(0.0, src_tex_offset0.t);
    offset[23] = vec2(src_tex_offset0.s, src_tex_offset0.t);
    offset[24] = vec2(src_tex_offset0.s, src_tex_offset0.t);

    kernel[0] = 1.0/9.0;   kernel[1] = 1.0/9.0;   kernel[2] = 1.0/9.0;   kernel[3] = 1.0/9.0;   kernel[4] = 1.0/9.0;
    kernel[5] = 1.0/9.0;   kernel[6] = 1.0/9.0;   kernel[7] = 1.0/9.0;   kernel[8] = 1.0/9.0;   kernel[9] = 1.0/9.0;
    kernel[10] = 1.0/9.0;   kernel[11] = 1.0/9.0;   kernel[12] = 1.0/9.0;   kernel[13] = 1.0/9.0;   kernel[14] = 1.0/9.0;
    kernel[15] = 1.0/9.0;   kernel[16] = 1.0/9.0;   kernel[17] = 1.0/9.0;   kernel[18] = 1.0/9.0;   kernel[19] = 1.0/9.0;
    kernel[20] = 1.0/9.0;   kernel[21] = 1.0/9.0;   kernel[22] = 1.0/9.0;   kernel[23] = 1.0/9.0;   kernel[24] = 1.0/9.0;

    for(i = 0; i < KERNEL_SIZE; i++)
    {
        vec4 tmp = texture2D(src_tex_unit0, gl_TexCoord[0].st + offset[i]);
        sum += tmp * kernel[i];
    }

    gl_FragColor = vec4(sum.rgb, 1.0);
}

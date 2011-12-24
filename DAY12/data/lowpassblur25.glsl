#define KERNEL_SIZE 25
// blur (low-pass) 3x3 kernel
// http://buza.mitplw.com/blog/?p=159

uniform sampler2D sampler0;
uniform vec2 tc_offset[KERNEL_SIZE];

void main(void)
{
    vec4 sample[ KERNEL_SIZE ];

    for (int i = 0; i < KERNEL_SIZE ; i++)
    {
        sample[i] = texture2D(sampler0, 
                              gl_TexCoord[0].st + tc_offset[i]);
    }

    gl_FragColor = (sample[0] + 
		    (4.0* sample[1]) + 
	            (7.0*sample[2]) + 
                    (4.0* sample[3]) + 
		    sample[4] + 
		    (4.0*sample[5]) + 
                    (20.0*sample[6]) + 
		    (33.0*sample[7]) + 
		    (20.0*sample[8]) +
		    (4.0*sample[9]) + 
		    (7.0*sample[10]) + 
	            (33.0*sample[11]) + 
                    (55.0*sample[12]) + 
		    (33.0*sample[13]) + 
		    (7.0*sample[14]) + 
                    (4.0*sample[15]) + 
		    (20.0*sample[16]) + 
		    (33.0*sample[17]) +
		    (20.0*sample[18]) + 
		    (4.0*sample[19]) + 
	            sample[20] + 
                    (4.0*sample[21]) + 
		    (7.0*sample[22]) + 
		    (4.0*sample[23]) + 
                    sample[24] 
		    ) / 331.0;
}

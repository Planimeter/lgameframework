//=========== Copyright © 2020, Planimeter, All rights reserved. =============//
//
// Purpose:
//
//==========================================================================//

#version 330

uniform mat4 view;
uniform mat4 projection;

in vec3 position;
in vec3 texcoord;

out vec3 TexCoord;

void main()
{
	vec4 pos    = projection * view * vec4( position, 1.0 );
	gl_Position = pos.xyww;
	TexCoord    = position;
}

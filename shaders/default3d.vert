//=========== Copyright © 2020, Planimeter, All rights reserved. =============//
//
// Purpose:
//
//==========================================================================//

#version 330

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

uniform mat4 normalMatrix;

in vec3 position;
in vec3 normal;
in vec3 tangent;
in vec2 texcoord;

out vec3 Normal;
out vec3 Tangent;
out vec2 TexCoord;

void main()
{
	gl_Position = projection * view * model * vec4( position, 1.0 );
	Normal      = normal;
	Tangent     = tangent;
	TexCoord    = texcoord;
}

//=========== Copyright © 2020, Planimeter, All rights reserved. =============//
//
// Purpose:
//
//==========================================================================//

#version 330

uniform sampler2D tex;
uniform vec4 color;

in vec2 TexCoord;

out vec4 FragColor;

void main()
{
	FragColor = texture( tex, TexCoord ) * color;
}

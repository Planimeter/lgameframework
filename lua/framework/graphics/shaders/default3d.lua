--=========== Copyright © 2018, Planimeter, All rights reserved. =============--
--
-- Purpose:
--
--============================================================================--

local GL      = require( "opengl" )
local ffi     = require( "ffi" )
local kazmath = require( "kazmath" )

return function()
	-- shader
	local fragmentSource = framework.filesystem.read( "shaders/default.frag" )
	local vertexSource   = framework.filesystem.read( "shaders/default3d.vert" )
	local shader         = framework.graphics.newShader( fragmentSource, vertexSource )
	GL.glBindFragDataLocation( shader, 0, "FragColor" )
	framework.graphics.linkShader( shader )
	framework.graphics.setShader( shader )

	-- default.frag
	-- uniforms
	-- tex
	framework.graphics.setDefaultTexture()

	-- color
	framework.graphics.setColor( { 255, 255, 255, 1 } )

	-- default3d.vert
	-- attribs
	-- position
	local position = GL.glGetAttribLocation( shader, "position" )
	local stride = ( 3 + 3 + 3 + 2 ) * ffi.sizeof( "GLfloat" )
	GL.glEnableVertexAttribArray( position )
	GL.glVertexAttribPointer( position, 3, GL.GL_FLOAT, 0, stride, nil )

	-- normal
	local normal = GL.glGetAttribLocation( shader, "normal" )
	GL.glEnableVertexAttribArray( normal )
	local pointer = ffi.cast( "GLvoid *", 3 * ffi.sizeof( "GLfloat" ) )
	GL.glVertexAttribPointer( normal, 3, GL.GL_FLOAT, 0, stride, pointer )

	-- tangent
	local tangent = GL.glGetAttribLocation( shader, "tangent" )
	GL.glEnableVertexAttribArray( tangent )
	pointer = ffi.cast( "GLvoid *", ( 3 + 3 ) * ffi.sizeof( "GLfloat" ) )
	GL.glVertexAttribPointer( tangent, 3, GL.GL_FLOAT, 0, stride, pointer )

	-- texcoord
	local texcoord = GL.glGetAttribLocation( shader, "texcoord" )
	GL.glEnableVertexAttribArray( texcoord )
	pointer = ffi.cast( "GLvoid *", ( 3 + 3 + 3 ) * ffi.sizeof( "GLfloat" ) )
	GL.glVertexAttribPointer( texcoord, 2, GL.GL_FLOAT, 0, stride, pointer )

	-- uniforms
	-- model
	local model = GL.glGetUniformLocation( shader, "model" )
	local mat4 = ffi.new( "kmMat4" )
	kazmath.kmMat4Identity( mat4 )
	GL.glUniformMatrix4fv( model, 1, GL.GL_FALSE, mat4.mat )

	-- view
	local view = GL.glGetUniformLocation( shader, "view" )
	GL.glUniformMatrix4fv( view, 1, GL.GL_FALSE, mat4.mat )

	-- projection
	local width, height = framework.graphics.getSize()
	framework.graphics.setOrthographicProjection( width, height )

	return shader
end
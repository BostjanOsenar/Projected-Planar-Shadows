# Projected Planar Shadows in Unity
This is a proof-of-concept project that demonstrates possible implementation of
planar shadows in Unity.

The shadows are created by taking a mesh and projecting it onto a flat plane.
This is implemented using a shader that performs vertex deformations and a
controller script that has to be attached to each shadow mesh object in order to
set the shadow receiving plane's normal information on the shader.

## The good
Projected mesh creates hard shadows that can be very fast to render. They work
really well on flat surfaces only. A high-poly mesh of shadow caster object can
be replaced with lower-poly version for the shadow or a primitive to further
increase performance.

## The bad
They work well on flat or relatively flat surfaces only. Objects can not have
self-shadow, other than shadow receiving plane no other objects receive the
shadow.

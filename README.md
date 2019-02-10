# Projected Planar Shadows in Unity
This is a proof-of-concept project that demonstrates possible implementation of
planar shadows in Unity.

![Teapots with projected planar shadows](https://www.cosmicworks.io/blog/implementing-planar-shadows-in-unity/images/figure-teapots-mesh-view.jpg)

The shadows are created by taking a mesh and projecting it onto a flat plane.
This is implemented using a shader that performs vertex deformations and a
controller script that has to be attached to each shadow mesh object in order to
set the shadow receiving plane's normal information on the shader.

The project is set-up to have two teapots with shadow meshes, one with low-poly
and other high-poly mesh. To prevent Z-fighting the shadow receiving plane has a
small offset from the actual ground plane.

## The good
Projected mesh creates hard shadows that can be very fast to render. They work
really well on flat surfaces only. A high-poly mesh of shadow caster object can
be replaced with lower-poly version for the shadow or a primitive to further
increase performance.

## The bad
They work well on flat or relatively flat surfaces only. Objects can not have
self-shadow, other than shadow receiving plane no other objects receive the
shadow. Z-fighting can occur.

---
[Read more][Blog]

[Blog]: https://www.cosmicworks.io/blog/2019/02/implementing-planar-shadows-in-unity/

vector3
=========================

![License](https://img.shields.io/badge/License-GPLv3-blue.svg)
[![ContentDB](https://content.minetest.net/packages/giga-turbo/vector3/shields/downloads/)](https://content.minetest.net/packages/giga-turbo/vector3/)

**3D Vector library with meta functions**

**License:** GPLv3   

## Usage

1. Make your mod depends on `vector3` ;
2. Create vectors with `vector3(x, y, z)` ;
3. See available methods below

All functions create __new vectors__ so that the original vector is not modified. All the functions return the new vector so that operations can be chained easily.

*Example:*
```lua
u = vector3(1, 2, 3)
v = vector3(4, 5, 6)
w = (5 * u + u:dot(v) * u:cross(v:scale(5))):norm()
```

## Constructors

#### vector3(x, y, z)
Creates a new vector with components `x`, `y` and `z`. Components defaults to zero.

```lua
v0 = vector3() -- (0,0,0)
v1 = vector3(1,2,3) -- (1,2,3)
```

#### vector3.fromSpherical(r, theta, phi)
Creates a new vector from spherical coordinates. `theta` is the polar angle (from the upwards `y` axis), `phi` the azimut (counting clockwise around `y`, starting from `x`), and `r` the radius. Default values are `r=1`, `theta=pi/2`, `phi=0` so that the resulting vector is `(1,0,0)`.

```lua
v2 = vector3.fromSpherical(10, math.pi / 2, math.pi) -- (10, 0, 0)
```

#### vector3.random(length)
Creates a vector with a random direction and magnitude of `length` (defaults to 1).

```lua
v3 = vector3.random()
```

## Meta functions

#### print
Allows to print a vector.

```lua
print(v1)
```

#### concatenation
Allows to create strings from vector concatenation.

```lua
print(v1 .. v2 .. v3)
```

#### negative
Returns the opposite vector.

```lua
v5 = -v1
```

#### equality
Return true if two vectors have their components equals

```lua
v1 == v2
```

#### addition
Return the sum of two vectors component wise. If one argument is a number then this number is added to each component of the vector.

```lua
v1 + v2
v1 + 10
```

#### subtraction
Return the difference of two vectors component wise. If one argument is a number then this number is subtracted to each component of the vector.

```lua
v1 - v2
v1 - 1
```

#### multiplication
Return the product of two vectors component wise. If one argument is a number then each component of the vector is multiplied by this number.

```lua
v1 * v2
v1 * 10
```

#### division
Return the division of two vectors component wise. If one argument is a number then each component of the vector is divided by this number.

```lua
v1 / v3
v1 / 10
```

## Functions

#### clone()
Return a new vector which is a copy of the initial vector.

```lua
v4 = v1:clone()
```

#### length()
Returns the magnitude of the vector.

```lua
v3:length()
```

#### norm()
Return the corresponding normalized vector (with magnitude one).

```lua
v3:norm()
```

#### scale(mag)
Return a new vector which is scaled to magnitude `mag`

```lua
v1:scale(10)
```

#### limit(max)
Returns a new vector which is scaled to magnitude `max` if its magnitude if greater than `max`.

```lua
vector3(10, 20, 30):limit(5)
vector3(1, 2, 3):limit(5)
```

#### floor()
Return a new vector with the components floored.

```lua
v3:floor()
```

#### round()
Return a new vector with the components rounded to the closest integer.

```lua
v3:round()
```

#### set(x, y, z)
Return a new vector with components `x`,`y` and `z`. If a parameter is nil then the corresponding component is unchanged.

```lua
v1:set(4, nil, 7)
```

#### offset(a, b, c)
Return a new vector with components `x`, `y`, `z` offset by `a`, `b` and `c`. If a parameter is nil the corresponding component is unchanged.

```lua
v2:offset(-1, 3, 2)
```

#### apply(f)
Return a new vector with the function `f` applied to its components.

```lua
v2:apply(function(x) return x * x end)
```

#### dist(b)
Returns the distance between the current vector and `b` (as if they were representing points).

```lua
v1:dist(v2)
```

#### dot(b)
Returns the dot product of the current vector and `b`.

```lua
v1:dot(v2)
```

#### cross(b)
Returns a vector which is the cross product of the current vector and `b`.

```lua
v1:cross(v2)
```

#### rotate_around(axis, angle)
Returns a new vector which is the current vector rotated around `axis` with `angle`.

```lua
axis = vector3(0, 1, 0)
v2:rotate_around(axis, math.pi)
```

#### unpack()
Returns the unpacked components of the current vector.

```lua
x, y, z = v1:unpack()
print(x)
print(y)
print(z)
```